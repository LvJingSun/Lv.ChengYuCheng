//
//  BcreateblockViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-3-30.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "BcreateblockViewController.h"
#import "CardMemberListViewController.h"

#import "CardLevelViewController.h"

@interface BcreateblockViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_levelBtn;

// 会员卡等级设置按钮触发的事件
- (IBAction)levelBtnClicked:(id)sender;

@end

@implementation BcreateblockViewController
@synthesize m_dic;
@synthesize m_type;
@synthesize m_shopList;
@synthesize m_shopId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.m_dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    self.m_shopId = @"";
    if ([m_type isEqualToString:@"2"]) {
        
        self.title = @"编辑卡";

        releaseBtn.hidden = YES;
//        [self setRightButtonWithTitle:@"会员" action:@selector(rightClicked)];
        NameTextField.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardTitle"]];
        DescribeView.text =[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"description"]];
        simplelabel.text = @"";
        
        self.m_shopList = [self.m_dic objectForKey:@"VoucherMctShopList"];
        [self getShopId:self.m_shopList];
        
        [self setRightButtonWithTitle:@"查看会员" action:@selector(accountList)];
        
        
        
        // 编辑卡的时候才可以看到会员卡等级设置的按钮
        self.m_levelBtn.hidden = NO;
        // 设置按钮的边框
        self.m_levelBtn.layer.borderWidth = 1.0;
        self.m_levelBtn.layer.borderColor = RGBACKTAB.CGColor;
        self.m_levelBtn.layer.masksToBounds = YES;

        // 赋值
        vipCardId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardId"]];

        
    }else{
        
        self.title = @"创建卡";

        saveBtn.hidden = YES;
        
        self.navigationItem.rightBarButtonItem = nil;
        
        // 创建卡的时候只有创建成功后提示用户是否去设置会员卡的等级
        self.m_levelBtn.hidden = YES;

        vipCardId = @"";
        
    }
    
    
    NameTextField.delegate = self;
    DescribeView.delegate = self;
    
    [m_scrollerView setContentSize:CGSizeMake(m_scrollerView.frame.size.width, self.view.frame.size.height)];
    
    

    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}


- (void)leftClicked{
    
    [self goBack];
}

- (void)accountList{
    
    NSLog(@"vipCardId = %@",[self.m_dic objectForKey:@"cardId"]);
    
    // 进入到会员列表的页面
    CardMemberListViewController *VC = [[CardMemberListViewController alloc]initWithNibName:@"CardMemberListViewController" bundle:nil];
    VC.m_vipCardId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardId"]];
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)topcotrol:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self hiddenNumPadDone:nil];
}
- (void)textViewDidBeginEditing:(UITextView *)textView;{
    [self hiddenNumPadDone:nil];

}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        simplelabel.text = @"请填写卡的详细说明";
    }else{
        simplelabel.text = @"";
    }
}

-(IBAction)Choseshop:(id)sender
{
    // 进入店铺选择的页面
    HH_shopListViewController *VC = [[HH_shopListViewController alloc]initWithNibName:@"HH_shopListViewController" bundle:nil];
    VC.delegate = self;
    VC.m_shopArray = self.m_shopList;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - ShopListDelegate
- (void)getShopList:(NSMutableArray *)aShopArray{
    
    // 数组有值时将数据先清空
    if ( self.m_shopList.count != 0 ) {
        
        [self.m_shopList removeAllObjects];
    }
    // 添加到数组里
    [self.m_shopList addObjectsFromArray:aShopArray];
    
    if ( aShopArray.count != 0 ) {
        
        [self getShopId:aShopArray];
        
    }
}

// 赋值shopId和shopname
- (void)getShopId:(NSMutableArray *)arr{
    
    if ( arr.count != 0 ) {
        
        NSString *nameString = @"";
        
        NSString *shopIdString = @"";
        
        for (int i = 0; i < arr.count; i++) {
            
            NSDictionary *dic = [arr objectAtIndex:i];
            
            NSString *name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopName"]];
            
            NSString *shopId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctShopID"]];
            
            // 赋值
            if ( i != arr.count - 1 ) {
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@,",name]];
                
                shopIdString = [shopIdString stringByAppendingString:[NSString stringWithFormat:@"%@,",shopId]];
                
            }else{
                
                nameString = [nameString stringByAppendingString:[NSString stringWithFormat:@"%@",name]];
                
                shopIdString = [shopIdString stringByAppendingString:[NSString stringWithFormat:@"%@",shopId]];
                
            }
            
            Shoplabel.text = [NSString stringWithFormat:@"%@",nameString];
                        
            Shoplabel.textColor = RGBACKTAB;//[UIColor blackColor];
            
            self.m_shopId = [NSString stringWithFormat:@"%@",shopIdString];
            
        }
        
    }else{
        
        Shoplabel.textColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:211/255.0 alpha:1.0];
        self.m_shopId = @"";
        
    }
    
}

- (IBAction)requestSubmitblock:(id)sender{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    if (NameTextField.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入卡的名称"];
        return;
    }else if (DescribeView.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请输入卡的使用描述"];
        return;
    }else if ([self.m_shopId isEqualToString:@""]){
        [SVProgressHUD showErrorWithStatus:@"请选择所支持的店铺"];
        return;
    }
    NSString *type = @"";
    if ([m_type isEqualToString:@"1"]) {
        type = @"add";
        vipCardId = @"";
    }else if ([m_type isEqualToString:@"2"]){
        type = @"modify";
        vipCardId = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"cardId"]];
    }
    
    [SVProgressHUD showWithStatus:@"数据提交中..."];

    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           [NSString stringWithFormat:@"%@",NameTextField.text],@"cardTitle",
                           [NSString stringWithFormat:@"%@",DescribeView.text],@"description",
                           [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MERCHANTID]],@"merchantId",
                           self.m_shopId,@"merchantShopId",
                           type,@"type",
                           vipCardId,@"vipCardId",
                           @"",@"amount",
                           nil];
    
    [httpClient request:@"PubVIPCard.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        NSString *msg = [json valueForKey:@"msg"];

        if (success) {

            [SVProgressHUD showSuccessWithStatus:msg];
            [self.Bcreatedelegate BcretablockOver];
//            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(leftClicked) userInfo:nil repeats:NO];
            
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil
                                                               message:@"设置会员卡等级?"
                                                              delegate:self
                                                     cancelButtonTitle:@"下次再说"
                                                     otherButtonTitles:@"立即设置", nil];
            alertView.tag = 1382;
            [alertView show];
            

         } else {
             
            [SVProgressHUD showErrorWithStatus:msg];
             
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"操作失败,请稍后再试"];
    }];
}

- (IBAction)levelBtnClicked:(id)sender {
    
    // 进入会员等级列表的页面
    CardLevelViewController *VC = [[CardLevelViewController alloc]initWithNibName:@"CardLevelViewController" bundle:nil];
//    VC.m_cardId = vipCardId;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 1382 ) {
        
        if ( buttonIndex == 1 ) {
            
            // 设置会员卡等级的状态
            [self levelBtnClicked:nil];
            
        }else{
            
            // 返回上一级
            [self goBack];
        }
    }
}

@end
