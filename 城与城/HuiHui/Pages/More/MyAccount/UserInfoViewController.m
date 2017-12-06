//
//  UserInfoViewController.m
//  baozhifu
//
//  Created by mac on 14-3-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UserInfoViewController.h"

#import "UserDetailCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "TransactionViewController.h"




@interface UserInfoViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UIView *m_tempView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *m_sexImgV;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (strong, nonatomic) IBOutlet UIView *m_footerView;



- (IBAction)callBtnClicked:(id)sender;

- (IBAction)sendMsgClicked:(id)sender;


@end

@implementation UserInfoViewController

@synthesize isSendMessage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isSendMessage = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setTitle:@"用户信息"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 判断男女性别
    if ( [[self.m_dic objectForKey:@"Sex"] isEqualToString:@"Female"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie.png"];
        
    }else if ( [[self.m_dic objectForKey:@"Sex"] isEqualToString:@"Male"] ) {
        
        self.m_sexImgV.image = [UIImage imageNamed:@"gr_xingbie2.png"];
        
    }else{
        
        self.m_sexImgV.image = [UIImage imageNamed:@""];

        
    }
    
    // 姓名赋值
//    self.m_nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[self.m_dic objectForKey:@"NickName"],[self.m_dic objectForKey:@"RealName"]];
    
    NSString *remarkName = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RemarkName"]];
    
    if ( remarkName.length != 0 ) {
        
        self.m_nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[self.m_dic objectForKey:@"RemarkName"],[self.m_dic objectForKey:@"NickName"]];

    }else{
        
        self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"NickName"]];

    }
    
    
    // 赋值图片
    NSString *path = [self.m_dic objectForKey:@"PhotoMidUrl"];
    
    [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                            placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                         self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                         
                                         self.m_imageView.image = image;
                                       
                                         self.m_imageView.contentMode = UIViewContentModeScaleAspectFit;

                                         
                                     }
                                     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                         
                                     }];
    
    
    // 设置tableView的footerView
//    self.m_tableView.tableFooterView = self.m_footerView;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    self.isSendMessage = NO;

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ( !self.isSendMessage ) {
        
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

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return 4;
    
    return 5;
    
//    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"UserDetailCellIdentifier";
    
    UserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UserDetailCell" owner:self options:nil];
        
        cell = (UserDetailCell *)[nib objectAtIndex:0];
        
        
    }
    
//    if ( indexPath.row == 0 ) {
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.m_titleLabel.text = @"会员号";
//        
//        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberId"]];
//        
//    }else
    
    if ( indexPath.row == 0 ) {
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.m_titleLabel.text = @"手机号";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]];
   
    }else if ( indexPath.row == 1 ){
  
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.m_titleLabel.text = @"邮箱";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Email"]];

    }else if ( indexPath.row == 2 ){

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        cell.m_titleLabel.text = @"注册时间";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"JoinedDate"]];
        
    }else if ( indexPath.row == 3 ){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.m_titleLabel.text = @"状态";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"InviteState"]];
        
    }else if ( indexPath.row == 4 ){
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.m_titleLabel.text = @"备注名";
        
        cell.m_titleDetailLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RemarkName"]];
        
    }
//    else if ( indexPath.row == 5 ){
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        cell.m_titleLabel.text = @"来源";
//        
//        cell.m_titleDetailLabel.text = @"购买我的商品";
//        
//    }else if ( indexPath.row == 6 ){
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//
//        cell.m_titleLabel.text = @"交易记录";
//        
//        cell.m_titleDetailLabel.text = @"";
//        
//    }else if ( indexPath.row == 7 ){
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//
//        cell.m_titleLabel.text = @"沟通记录";
//        
//        cell.m_titleDetailLabel.text = @"";
    
//    }
    else {
        
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.row == 4 ) {
        // 修改备注名
        
        ModifyNoteViewController * VC = [[ModifyNoteViewController alloc]initWithNibName:@"ModifyNoteViewController" bundle:nil];
        VC.delegate = self;
        VC.toMemberId =[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"MemberId"]];
        VC.oldNotetext =[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RemarkName"]];
        
        [self.navigationController pushViewController:VC animated:YES];

        
    }
    
    /*
    if ( indexPath.row == 6 ) {
        // 交易记录
        TransactionViewController *VC = [[TransactionViewController alloc]initWithNibName:@"TransactionViewController" bundle:nil];
        
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( indexPath.row == 7 ){
        
        // 历史记录-进入聊天的页面
        SendMessageViewController *VC = [[SendMessageViewController alloc]initWithNibName:@"SendMessageViewController" bundle:nil];
        VC.m_chatPerson.userId = [self.m_dic objectForKey:@"MemberId"];
        VC.m_chatPerson.userNickName = [self.m_dic objectForKey:@"NickName"];
        VC.m_chatPerson.userHead = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"PhotoMidUrl"]];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
        
        
    }
    
    */
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (IBAction)callBtnClicked:(id)sender {
    
    NSString *phone = [self.m_dic objectForKey:@"Account"];
    
    // 调用此方法，进入通讯录后不返回程序  下面的方法将会返回程序当中
    //    NSURL *phoneNumberURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]];//telprompt
    //    [[UIApplication sharedApplication] openURL:phoneNumberURL];
    
    // 判断设备是否支持
    if([[[UIDevice currentDevice] model] rangeOfString:@"iPhone Simulator"].location != NSNotFound) {
        
        [SVProgressHUD showErrorWithStatus:@"该设备暂不支持电话功能"];
        
    }else{
        
        self.m_webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        [self.m_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone]]]];
        
    }

}

- (IBAction)sendMsgClicked:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否发送短信" delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 0:
            [self sendmessage];
            break;
        case 1:
            [alertView dismissWithClickedButtonIndex:1 animated:YES];
            break;
            
        default:
            break;
    }
}

- (void)sendmessage {

    if ([MFMessageComposeViewController canSendText]) {
        
        self.isSendMessage = YES;
        
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body = @"";
        picker.recipients = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"Account"]]];
        

        [self presentViewController:picker animated:YES completion:nil];

        
    } else {
        
        self.isSendMessage = NO;
        
        [SVProgressHUD showErrorWithStatus:@"该设备不支持短信功能"];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled) {
        
    }else if (result == MessageComposeResultSent) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    }else {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }
    
//    switch (result) {
//        case MessageComposeResultCancelled:
//            break;
//        case MessageComposeResultFailed:
//            [SVProgressHUD showErrorWithStatus:@"发送失败"];
//            break;
//        case MessageComposeResultSent:
//            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
//            break;
//        default:
//            break;
//    }
}

#pragma mark - ModifyRemarkNameDelegate
- (void)GetSaveRemarkName:(NSString *)RemarkName;
{
    [self.m_dic setObject:RemarkName forKey:@"RemarkName"];
    
    [self.m_tableView reloadData];
    
    NSString *remarkName = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"RemarkName"]];
    
    if ( remarkName.length != 0 ) {
        
        self.m_nameLabel.text = [NSString stringWithFormat:@"%@(%@)",[self.m_dic objectForKey:@"RemarkName"],[self.m_dic objectForKey:@"NickName"]];
        
    }else{
        
        self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_dic objectForKey:@"NickName"]];
        
    }
    
    // 修改备注名后进行记录值用于返回上一个页面进行刷新数据
    [CommonUtil addValue:@"1" andKey:@"RemarkNameKey"];

}

@end
