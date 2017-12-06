//
//  TakeMoneyViewController.m
//  baozhifu
//
//  Created by mac on 13-11-5.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "TakeMoneyViewController.h"

#import "SVProgressHUD.h"

#import "CommonUtil.h"

#import "AppHttpClient.h"

#import "CardInfoView.h"

#import "AddBankCardViewController.h"
#import "BankCardListViewController.h"
#import "CashWithdrawalsViewController.h"


@interface TakeMoneyViewController ()

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UILabel *m_priceLabel;

@property (weak, nonatomic) IBOutlet UITextField *m_crashPriceLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *bankListView;

// 提现按钮触发的事件
- (IBAction)takeMoneyRequest:(id)sender;

- (IBAction)backgroundTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *StatusBtn;

@end

@implementation TakeMoneyViewController

@synthesize keyShow;

@synthesize m_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.needDone = YES;
    
    keyShow = NO;
        
    [self setTitle:@"提现"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 赋值    
    self.m_priceLabel.text = [NSString stringWithFormat:@"￥%.2f",floor([self.m_inString doubleValue]*100)/100];

    self.bankListView.showsHorizontalScrollIndicator = NO;
    self.bankListView.showsVerticalScrollIndicator=NO;
    self.bankListView.pagingEnabled=YES;
    self.bankListView.delegate = self;
    
    // 请求数据
    [self loadData];

}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    [self hideTabBar:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setM_titleView:nil];
    [self setM_tempView:nil];
    [self setM_priceLabel:nil];
    [self setM_crashPriceLabel:nil];
    [self setBankListView:nil];
    [super viewDidUnload];
}

- (void)leftClicked{
    
    [self goBack];
}

- (IBAction)takeMoneyRequest:(id)sender {
    
    if ( self.m_crashPriceLabel.isFirstResponder ) {
        
        [self hidenKeyboard];
        
    }
    
    if ( self.m_crashPriceLabel.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入提现金额"];
        
        return;
    }
    
    // 判断输入多个小数点的情况
    NSArray *array = [self.m_crashPriceLabel.text componentsSeparatedByString:@"."];
    
    if ( array.count > 2 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"您输入的金额格式不对,请重新输入"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        [alertView show];
        
        return;
        
    }
    
    if ( [self.m_crashPriceLabel.text doubleValue] > [self.m_inString doubleValue] ) {
        
        [SVProgressHUD showErrorWithStatus:@"提现金额不能大于可提现的金额"];
        
        return;
    }
    
    if ( [self.m_crashPriceLabel.text doubleValue] < 10 ) {
        
        [SVProgressHUD showErrorWithStatus:@"提现金额不能小于10元"];
        
        return;
    }
    
    if ([self.xianeStatus isEqualToString:@"2"]) {
        
        if ([self.m_crashPriceLabel.text doubleValue] > [self.xianeCount doubleValue]) {
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"提现金额不能大于%@元",self.xianeCount]];
            
            return;
            
        }

    }

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"确定提现？"
                                                      delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag = 18942;
    [alertView show];
    
}

- (IBAction)backgroundTap:(id)sender {
    
    [self resumeView];
    
    [self.m_crashPriceLabel resignFirstResponder];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 18942 ) {
        
        if ( buttonIndex == 0 ) {
            
            
        }else if ( buttonIndex == 1 ){
            
            // 请求提现的数据
            [self requestSubmit];
            
        }
    }
}

// 请求数据
- (void)requestSubmit{
    
    
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
        
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [[self.m_array objectAtIndex:self.currentPage]objectForKey:@"MemberBankCardId"],   @"memberBankCardId",
                           self.m_crashPriceLabel.text,@"amount",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberWithdrawal.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
    
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

            [defaults setObject:@"xianshi" forKey:@"ljxianshiAD"];
                        
            [SVProgressHUD showSuccessWithStatus:msg];

            [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(BackLast) userInfo:nil repeats:NO];

        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (void)BackLast{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

// 完成按钮改为小数点
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (self.doneButton.superview)
    {
        [self.doneButton removeFromSuperview];
    }
    if (!keyShow) {
        return;
    }
    //    if (self.rootScrollView != nil) {
    //        NSDictionary *info = [notification userInfo];
    //        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    //        CGSize keybroundSize = [value CGRectValue].size;
    //        CGRect viewFrame = [self.rootScrollView frame];
    //        viewFrame.size.height += keybroundSize.height;
    //        self.rootScrollView.frame = viewFrame;
    //    }
    keyShow = NO;
}
- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    // create custom button
    if (self.doneButton == nil)
    {
        self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
//        if (screenHeight==568.0f) {//爱疯5
//            self.doneButton.frame = CGRectMake(0, 568 - 53, 106, 53);
//        } else {//3.5寸
//            self.doneButton.frame = CGRectMake(0, 480 - 53, 106, 53);
//        }

        // 6p的情况
        if ( screenHeight == 736.0f ) {
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 57, WindowSizeWidth/3 - 2, 57);
            
        }else{
            
            self.doneButton.frame = CGRectMake(self.view.frame.origin.x, screenHeight - 53, WindowSizeWidth/3 - 2, 53);
            
        }
        
        self.doneButton.adjustsImageWhenHighlighted = NO;
        self.doneButton.hidden=self.needDone;
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_normal.png"] forState:UIControlStateNormal];
        [self.doneButton setBackgroundImage:[UIImage imageNamed:@"btn_done_selected.png"] forState:UIControlStateHighlighted];
        [self.doneButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    if (self.doneButton.superview == nil)
    {
        [tempWindow addSubview:self.doneButton];    // 注意这里直接加到window上
    }
    self.doneButton.hidden=self.needDone;
    if (keyShow) {
        return;
    }
    //    if (self.rootScrollView != nil) {
    //        NSDictionary *info = [notification userInfo];
    //        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    //        CGSize keybroundSize = [value CGRectValue].size;
    //        CGRect viewFrame = [self.rootScrollView frame];
    //        viewFrame.size.height -= keybroundSize.height;
    //        self.rootScrollView.frame = viewFrame;
    //        //[self performSelector:@selector(moveToActiveView) withObject:nil afterDelay:0.5];
    //        [self moveToActiveView];
    //    }
    keyShow = YES;
    
    //    if ( self.m_activityField == self.m_priceTextField ) {
    //
    //        self.doneButton.userInteractionEnabled = YES;
    //
    //    }else{
    //
    //        self.doneButton.userInteractionEnabled = NO;
    //
    //    }
    
}

- (void)finishAction
{
    //    [self hidenKeyboard];
    
    self.m_crashPriceLabel.text = [self.m_crashPriceLabel.text stringByAppendingString:@"."];

}

- (IBAction)showKeyboard:(id)sender
{
    self.needDone = NO;
    self.doneButton.hidden = self.needDone;
}

- (IBAction)hideKeyboard:(id)sender
{
    self.needDone = YES;
    self.doneButton.hidden = self.needDone;
}

//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.m_crashPriceLabel resignFirstResponder];
   
    [self resumeView];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    [self hidenKeyboard];
    
    return YES;
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
        
    if ( textField == self.m_crashPriceLabel ) {
        
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        CGRect rect=CGRectMake(0.0f,-128,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
        
        self.doneButton.userInteractionEnabled = YES;
        
        [self showKeyboard:nil];
    
        
    }
    
    return YES;
    
}

//恢复原始视图位置
-(void)resumeView {
    
    if ( isIOS7 ) {
        
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        float Y = 0.0f;
        CGRect rect=CGRectMake(0.0f,Y + 60,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];

    }else{
        
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        float Y = 0.0f;
        CGRect rect=CGRectMake(0.0f,Y,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];

    }

}


- (void)setDataView:(NSArray *)bankCarList {
    CGFloat width = WindowSizeWidth - 85;//235;
    CGFloat height = 88;
    if (bankCarList == nil || [bankCarList count] == 0) {
        CGRect frame = CGRectMake(0, 0, width, height);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.text = @"您还未没有添加银行卡!";
        label.textAlignment = NSTextAlignmentCenter;
        [self.bankListView addSubview:label];
        self.bankListView.contentSize = CGSizeMake(width, height);
        return;
    }
    for (UIView *view in [self.bankListView subviews]) {
        [view removeFromSuperview];
    }
    int count = [bankCarList count];
    for (NSInteger index = 0; index < count; index++) {
        NSDictionary *bankInfo = [bankCarList objectAtIndex:index];
        NSString *isDefault = [bankInfo objectForKey:@"IsDefault"];
        if (isDefault.intValue == 1) self.currentPage = index;
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CardInfoView" owner:self options:nil];
        CardInfoView *view = [array objectAtIndex:0];
        view.backgroundColor = [UIColor clearColor];
        [view setData:bankInfo];
        view.frame = CGRectMake(width * index, 0, width, height);
        
//        if ([bankInfo[@"Status"] isEqualToString:@"VerificationSucc"]) {
//            
//            [self.StatusBtn setImage:[UIImage imageNamed:@"icon_bank_card_add.png"] forState:0];
//            
//        }else {
//        
//            [self.StatusBtn setImage:[UIImage imageNamed:@""] forState:0];
//            
//        }
        //[view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.bankListView addSubview:view];
    }
    self.bankListView.contentSize = CGSizeMake(width * count, height);
    [self.bankListView setContentOffset:CGPointMake(width * self.currentPage, 0) animated:YES];
}

#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index = fabs(self.bankListView.contentOffset.x) / self.bankListView.frame.size.width;

    self.currentPage = index;
    
}

- (IBAction)addBankCard:(id)sender {
//    AddBankCardViewController *viewController = [[AddBankCardViewController alloc] initWithNibName:@"AddBankCardViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    BankCardListViewController *viewController = [[BankCardListViewController alloc] initWithNibName:@"BankCardListViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)loadData {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberid",
                           key,   @"key",
                           @"VerificationSucc",   @"bnkListType",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"BankCarList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            NSArray *bankCarList = [json valueForKey:@"memberBankCard"];
            [self.m_array addObjectsFromArray: bankCarList];
            [self setDataView:bankCarList];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}


@end
