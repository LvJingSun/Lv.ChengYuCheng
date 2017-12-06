//
//  PayMentViewController.m
//  baozhifu
//
//  Created by mac on 13-6-9.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "PayMentViewController.h"
#import "SVProgressHUD.h"
#import "CommonUtil.h"
//#import "AppHttpClient.h"
#import "QRCodeGenerator.h"


static NSString * const WAITFORPAY = @"WaitForPay";

static NSString * const TRANSFER = @"Transfer";

@interface PayMentViewController ()

@property (weak, nonatomic) IBOutlet UIView *noPaymentView;

@property (weak, nonatomic) IBOutlet UIView *paymentView;

@property (weak, nonatomic) IBOutlet UILabel *txtPayNo;

@property (weak, nonatomic) IBOutlet UILabel *txtPayDate;

@property (weak, nonatomic) IBOutlet UILabel *txtMerchants;

@property (weak, nonatomic) IBOutlet UILabel *txtAddress;

@property (weak, nonatomic) IBOutlet UILabel *txtNick;

@property (weak, nonatomic) IBOutlet UILabel *txtAccount;

@property (weak, nonatomic) IBOutlet UILabel *txtAmount;

@property (weak, nonatomic) IBOutlet UIButton *preButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UITextField *payPassword;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView     *m_tempView;
// 待付的按钮
@property (weak, nonatomic) IBOutlet UIButton   *m_waitPayBtn;
// 转账的按钮
@property (weak, nonatomic) IBOutlet UIButton   *TransferBtn;
// 转账的view
@property (weak, nonatomic) IBOutlet UIControl  *m_transferView;
// 转账的账号
@property (weak, nonatomic) IBOutlet UITextField *m_accountTextField;
// 转账金额
@property (weak, nonatomic) IBOutlet UITextField *m_priceTextField;


@property (weak, nonatomic) IBOutlet UIView *m_titleView;


- (IBAction)backgroundTap:(id)sender;

- (IBAction)reflashData:(id)sender;

- (IBAction)nextPayment:(id)sender;

- (IBAction)prePayment:(id)sender;

- (IBAction)pay:(id)sender;

- (IBAction)refuse:(id)sender;
// 切换按钮触发的事件
- (IBAction)changeType:(id)sender;
// 扫描账号的二维码
- (IBAction)scan:(id)sender;
// 确认转账
- (IBAction)transferMakeSure:(id)sender;



@end
 
@implementation PayMentViewController

@synthesize keyShow;

@synthesize m_dic;

@synthesize m_array;

@synthesize mWidgetController;
@synthesize readline;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_array = [[NSArray alloc]init];
        
        // 发送键盘通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        self.isScan = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setTitle:@"付款"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.needDone = YES;
    
    keyShow = NO;
    
    self.isShowScan = NO;
    
//    self.m_scanBtn.hidden = NO;
    
//     NSString *string = [CommonUtil getValueByKey:ACCOUNT];
//    
//    // 生成二维码图片 
//    UIImage *codeImage = [QRCodeGenerator qrImageForString:string imageSize:self.m_scanImageV.frame.size.width];
//    [self.m_scanImageV setImage:codeImage];
    
       
        
    [self.noPaymentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"waitPay_background"]]];
    
    [self.m_transferView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"waitPay_background"]]];
    
    [self.payPassword setDelegate:self];
    
    [self.m_waitPayBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.m_waitPayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.m_waitPayBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateSelected];
    
    [self.m_waitPayBtn setTitleColor:[UIColor colorWithRed:46/255.0 green:133/255.0 blue:179/255.0 alpha:1.0] forState:UIControlStateSelected];
    
    [self.TransferBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_def.png"] forState:UIControlStateNormal];
    [self.TransferBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.TransferBtn setBackgroundImage:[UIImage imageNamed:@"comm_tabar_selected.png"] forState:UIControlStateSelected];
     [self.TransferBtn setTitleColor:[UIColor colorWithRed:46/255.0 green:133/255.0 blue:179/255.0 alpha:1.0] forState:UIControlStateSelected];
    
    // 隐藏所有的view
    self.m_transferView.hidden = YES;
    self.paymentView.hidden = YES;
    self.noPaymentView.hidden = YES;
    

    // 设置scrollerView可以滚动的范围
    [self.scrollView setContentSize:CGSizeMake(WindowSizeWidth, 500)];

    // 默认选中第一个
    [self setLeftBtn:YES withRightBtn:NO];
    
    [self reloadDataView];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];
     
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    self.isScan = NO;
    
    ISscaning = NO;

}

-(void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    if ( !self.isScan ) {
        
        [self hideTabBar:NO];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}
- (void)scangoback{
    
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
    
    if ( self.m_activityField == self.m_priceTextField ) {
        
        self.m_priceTextField.text = [self.m_priceTextField.text stringByAppendingString:@"."];
        
    }
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

- (void)loadViewData {
    NSDictionary * payment = [self.paymentRecord objectAtIndex:self.index];
    self.txtPayNo.text = [payment objectForKey:@"cashRegisterRecordNumber"];
    self.txtPayDate.text = [payment objectForKey:@"createDate"];
    self.txtMerchants.text = [NSString stringWithFormat:@"%@\n%@", [payment objectForKey:@"merchantName"], [payment objectForKey:@"merchantShopName"]];
    
    self.txtAddress.text = [payment objectForKey:@"merchantShopAddress"];
    self.txtNick.text = [payment objectForKey:@"realName"];
    self.txtAccount.text = [payment objectForKey:@"phone"];
    self.txtAmount.text = [NSString stringWithFormat:@"%.2f", [[payment objectForKey:@"amount"] doubleValue]];
    
    if (self.index <= 0) {
        self.preButton.hidden = YES;
    } else {
        self.preButton.hidden = NO;
    }
    if (self.index >= ([self.paymentRecord count] - 1)) {
        self.nextButton.hidden = YES;
    } else {
        self.nextButton.hidden = NO;
    }
    //NSLog(@"frame(%.0f, %.0f, %.0f, %.0f)", self.scrollView.frame.origin.x,self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    //NSLog(@"contentSize(%.0f, %.0f)", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
}

- (void)reloadDataView {
    if (self.paymentRecord == nil || [self.paymentRecord count] <= 0) {
        
        
        self.paymentView.hidden = YES;
        
        self.noPaymentView.hidden = NO;
        
        CGRect rect = self.noPaymentView.frame;
        rect.origin.x = 0;
        self.noPaymentView.frame = rect;
        
        rect = self.paymentView.frame;
        rect.origin.x = WindowSizeWidth;
        self.paymentView.frame = rect;
        
    } else {
        
        self.paymentView.hidden = NO;
        
        self.noPaymentView.hidden = YES;
        
        CGRect rect = self.noPaymentView.frame;
        rect.origin.x = WindowSizeWidth;
        self.noPaymentView.frame = rect;
        
        rect = self.paymentView.frame;
        rect.origin.x = 0;
        self.paymentView.frame = rect;
        
        [self loadViewData];
    }
}

// 二维码所在的view的点击事件
- (IBAction)backgroundTap:(id)sender {
    
    // 如果二维码的view是展开的，则点击按钮的时候收起
    if ( self.isShowScan ) {
        
        self.isShowScan = !self.isShowScan;
        
    }
    
}

- (IBAction)reflashData:(id)sender {
    
    // 如果二维码的view是展开的，则点击按钮的时候收起
    if ( self.isShowScan ) {
        
        self.isShowScan = !self.isShowScan;
        
//        [self translateCenterAnimate:self.m_scanView andSize:CGSizeMake(0, -346)];
    }

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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PaymentRecord.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            self.paymentRecord = [json valueForKey:@"paymentRecord"];
            self.index = 0;
//            self.paymentView.hidden = NO;
            [self reloadDataView];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (IBAction)nextPayment:(id)sender {
    self.index++;
    [self loadViewData]; 
}

- (IBAction)prePayment:(id)sender {
    self.index--;
    [self loadViewData];
}

- (IBAction)pay:(id)sender {
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
   [self hidenKeyboard];
   
    NSString *payPassword = self.payPassword.text;
    if (payPassword.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入支付密码"];
        return;
    }
    
    id recordId = [[self.paymentRecord objectAtIndex:self.index] objectForKey:@"cashRegisterRecordId"];
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           recordId,     @"cashRegisterRecordId",
                           payPassword,  @"password",
                           memberId,     @"memberid",
                           key,   @"key",
                           nil];
    
    [SVProgressHUD showWithStatus:@"支付中..."];
    [httpClient request:@"PaymentConfirm.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
//            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            [SVProgressHUD dismiss];
                        
            NSString *msg = [json valueForKey:@"msg"];
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag = 100;
            [alertView show];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            //[SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (IBAction)refuse:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定取消？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    alertView.tag = 101;
    [alertView show];
}

- (void)setLeftBtn:(BOOL)aLeft withRightBtn:(BOOL)aRight{
    
    self.m_waitPayBtn.selected = aLeft;
    
    self.TransferBtn.selected = aRight;
        
    if ( aLeft ) {
                        
        self.m_waitPayBtn.userInteractionEnabled = NO;
        
        self.TransferBtn.userInteractionEnabled = YES;
        
        // 请求数据
        [self reflashData:nil];
        
        self.itemType = WAITFORPAY;
        
        self.m_transferView.hidden = YES;
        //=====test====
        self.noPaymentView.hidden = NO;

    }
    
    if ( aRight ) {
        
        self.TransferBtn.selected = YES;
        
        self.paymentView.hidden = YES;
        
        self.noPaymentView.hidden = YES;
        
        self.m_transferView.hidden = NO;
        
        self.m_waitPayBtn.userInteractionEnabled = YES;
        
        self.TransferBtn.userInteractionEnabled = NO;
        
        self.itemType = TRANSFER;
        
    }
    
}

// 按钮切换
- (IBAction)changeType:(id)sender {
    
    [self.m_priceTextField resignFirstResponder];
    [self.m_accountTextField resignFirstResponder];
    
    // 如果二维码的view是展开的，则点击按钮的时候收起
    if ( self.isShowScan ) {
        
        self.isShowScan = !self.isShowScan;
        
    }

    if (sender == self.m_waitPayBtn) {
        
//        self.m_scanBtn.hidden = NO;
        
        [self setLeftBtn:YES withRightBtn:NO];

    }
    if (sender == self.TransferBtn) {
        
//        self.m_scanBtn.hidden = YES;
        
        [self setLeftBtn:NO withRightBtn:YES];
        
    }
    
}

// 进入二维码扫描
- (IBAction)scan:(id)sender {
    
    self.isScan = YES;
    
    [self.m_accountTextField resignFirstResponder];
    
    [self.m_priceTextField resignFirstResponder];
    
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.showsZBarControls = NO;
    reader.wantsFullScreenLayout = NO;
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];

    
    UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setFrame:CGRectMake(0, 0, 25, 25)];
    _button.backgroundColor = [UIColor clearColor];
    [_button setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(scangoback) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];;
    label.text = @"账号扫描";
    reader.navigationItem.titleView = label;
    
    UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [reader.navigationItem setLeftBarButtonItem:_barButton];
    
    [self ZbarViewdid:reader];

    
    [self.navigationController pushViewController:reader animated:YES];
    
}

#pragma mark ZxingDelegate
#pragma mark uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (ISscaning) {
        return;
    }
    ISscaning = YES;
    
    [self playSound];
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    self.m_accountTextField.text = [NSString stringWithFormat:@"%@",symbol.data];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissModalViewControllerAnimated:YES];
}
//- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
//    
//    // 扫描成功后进行赋值
//    self.m_accountTextField.text = [NSString stringWithFormat:@"%@",result];
//    
//    [self.navigationController popViewControllerAnimated:YES];
//
//}
//
//- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
//    //    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    [self.navigationController popViewControllerAnimated:YES];
//    
//}

- (IBAction)transferMakeSure:(id)sender {
    
    [self.m_accountTextField resignFirstResponder];
    
    [self.m_priceTextField resignFirstResponder];
    
    if ( self.m_accountTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入收银员账号"];
        
        return;
    }
    
    if ( self.m_priceTextField.text.length == 0 ) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入转账金额"];
        
        return;
    }
    
    // 判断输入多个小数点的情况
    NSArray *array = [self.m_priceTextField.text componentsSeparatedByString:@"."];
    
    if ( array.count > 2 ) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"您输入的价钱格式不对,请重新输入"
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles: nil];
        [alertView show];
        
        return;
        
    }
    
    // 请求接口
    [self transferRequest];
    
}

// 转账请求数据
- (void)transferRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.m_accountTextField.text,     @"cashierAccount",
                           self.m_priceTextField.text ,  @"amount",
                           memberId,     @"memberid",
                           key,   @"key",
                           nil];
    
    //    [SVProgressHUD showWithStatus:@"支付中..."];
    [httpClient request:@"MemberTransfer.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
                        
            // 成功后清空数据，返回到待付页面刷新数据
            self.m_accountTextField.text = @"";
            self.m_priceTextField.text = @"";
            
            // 发起收银成功后直接返回待付页面，进行刷新数据
            [self setLeftBtn:YES withRightBtn:NO];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (IBAction)groundTap:(id)sender {
    
    [self.m_priceTextField resignFirstResponder];
    
    [self.m_accountTextField resignFirstResponder];
}


-(void)translateCenterAnimate:(UIView *)view andSize:(CGSize)size {
    [UIView animateWithDuration:0.5 animations:^{
        view.center = CGPointMake(view.center.x + size.width, view.center.y + size.height);
    } completion:^(BOOL finished) {
        
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if ( alertView.tag == 101 ) {
        
        if (0 == buttonIndex) {
            
            // 判断网络是否存在
            if ( ![self isConnectionAvailable] ) {
                
                return;
            }
            
            id recordId = [[self.paymentRecord objectAtIndex:self.index] objectForKey:@"cashRegisterRecordId"];
            NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
            NSString *key = [CommonUtil getServerKey];
            AppHttpClient* httpClient = [AppHttpClient sharedClient];
            NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                                   recordId,     @"crrId",
                                   memberId,     @"memberId",
                                   key,   @"key",
                                   nil];
            [SVProgressHUD showWithStatus:@"订单取消中"];
            [httpClient request:@"PaymentRefuse.ashx" parameters:param success:^(NSJSONSerialization* json) {
                BOOL success = [[json valueForKey:@"status"] boolValue];
                if (success) {
                    NSString *msg = [json valueForKey:@"msg"];
                    [SVProgressHUD showSuccessWithStatus:msg];
                    [self reflashData:nil];
                } else {
                    NSString *msg = [json valueForKey:@"msg"];
                    [SVProgressHUD showErrorWithStatus:msg];
                }
            } failure:^(NSError *error) {
                //NSLog(@"failed:%@", error);
                [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            }];
        }

    }else if ( alertView.tag == 100){
        
        if ( buttonIndex == 0 ) {
            
            // 清空密码
            self.payPassword.text = @"";
            
            // 刷新数据
            [self reflashData:nil];
        }
    }

}


//隐藏键盘的方法
-(void)hidenKeyboard {
    [self.payPassword resignFirstResponder];
    [self.m_accountTextField resignFirstResponder];
    [self.m_priceTextField resignFirstResponder];
    
    [self resumeView];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    
    [self hidenKeyboard];
    
    return YES;
    
}

//UITextField的协议方法，当开始编辑时监听
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.m_activityField = textField;
    
    if ( textField == self.payPassword ) {
        
        NSTimeInterval animationDuration=0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        float width = self.view.frame.size.width;
        float height = self.view.frame.size.height;
        CGRect rect=CGRectMake(0.0f,-128,width,height);
        self.view.frame=rect;
        [UIView commitAnimations];
       
        [self hideKeyboard:nil];

        
    }else if ( textField == self.m_priceTextField ){
        
        self.doneButton.userInteractionEnabled = YES;
        
        [self showKeyboard:nil];
        
    }else{
        
        [self hideKeyboard:nil];
    }
    
    return YES;

}

//恢复原始视图位置
-(void)resumeView {
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    float Y = 0.0f;

    CGRect rect;
    
    if ( isIOS7 ) {
        
        rect=CGRectMake(0.0f,64.0f,width,height);

    }else{
        
        rect=CGRectMake(0.0f,Y,width,height);

    }
    
    self.view.frame=rect;
    [UIView commitAnimations];
}

- (void)viewDidUnload {
    
    [self setM_waitPayBtn:nil];
    [self setTransferBtn:nil];
    [self setM_transferView:nil];
    [self setM_accountTextField:nil];
    [self setM_priceTextField:nil];
    [self setM_titleView:nil];
    [super viewDidUnload];
}

-(void)playSound
{
    //注册声音到系统
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep-beep" ofType:@"caf"]],&shake_sound_male_id);
    AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
}

-(void)ZbarViewdid:(ZBarReaderViewController *)View;
{
    self.mWidgetController = View;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationRunFromBack) name:@"RunFromBackground"  object:nil];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    UIImageView *backImg = [[UIImageView alloc]init];
    if (iPhone5) {
        backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saomiaokuang@2x.png"]];
        [backImg setFrame:CGRectMake((WindowSizeWidth-191)/2, 82+40, 191, 259)];
    }else{
        backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saomiaokuang.png"]];
        [backImg setFrame:CGRectMake((WindowSizeWidth-191)/2, 38+40, 191, 259)];
    }
    [self.mWidgetController.view addSubview:backImg];
    
    [self performSelector:@selector(addAnimations) withObject:nil afterDelay:1.0];
    
}

-(void)addAnimations
{
    //stop loading
    [activity stopAnimating];
    //显示视图
    activityLabel.hidden = YES;
    //    overlayView.hidden=NO;
    
    readline =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"line_saomiao"]];
    readline.contentMode = UIViewContentModeScaleAspectFit;
    readline.frame=CGRectMake(0, 0, 157,7);
    [self.mWidgetController.view addSubview:readline];
    
    //添加图片的layer动画
    [self addLineImageAnimation];
}
// lineImage动画
-(void)addLineImageAnimation
{
    //添加图片的layer动画
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position"];
    if (iPhone5) {
        translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 85+40)];
        translation.toValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 240+40)];
    }else{
        
        translation.fromValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 40+40)];
        translation.toValue = [NSValue valueWithCGPoint:CGPointMake(WindowSizeWidth/2, 210+40)];
    }
    translation.duration = 2;
    translation.repeatCount = HUGE_VALF;
    translation.autoreverses = YES;
    
    [readline.layer addAnimation:translation forKey:@"translation"];
}
// 后台进入前台通知动画继续
- (void)getNotificationRunFromBack
{
    //添加图片的layer动画
    [self addLineImageAnimation];
}

@end
