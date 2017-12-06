//
//  FreshViewController.m
//  HuiHui
//
//  Created by mac on 13-11-19.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "FreshViewController.h"

//#import <QRCodeReader.h>

#import "DynamicViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "ResultViewController.h"

#import "WebViewController.h"

//#import "TwoDDecoderResult.h"

#import "f_activityViewController.h"

#import "f_partyViewController.h"

#import "CtriphotelViewController.h"

#import "UIImageView+AFNetworking.h"

#import "CtripwebViewController.h"

#import "HH_PartyListViewController.h"

#import "FlightsViewController.h"

#import "TicketsViewController.h"
#import "TrainwebViewController.h"


#import "QuanquanViewController.h"

#import "MyAddressListViewController.h"

#import "Fl_webViewController.h"

#import "Sec_webViewController.h"

#import "Hotel_webViewController.h"

#import "QuanquanListViewController.h"

#import "BblockslistViewController.h"

@interface FreshViewController ()

@property (weak, nonatomic) IBOutlet UITableView    *m_tableView;


@end

@implementation FreshViewController

@synthesize mWidgetController;
@synthesize readline;
//@synthesize isChooseScanImage;

@synthesize RedTipCnt;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        isChooseScanImage = NO;
        
        RedTipCnt = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        friendHelp = [[FriendHelper alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"新鲜"];
    
    // 记录红点的值
    self.m_dynamicString = @"";
    
    self.m_DynamicCommentsString = @"";
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    ISscaning = NO;
    
    self.navigationController.navigationBarHidden = NO;
    
//    self.isChooseScanImage = NO;
    
    // 数据库中读取数据
    NSString *dynamicString = [friendHelp DynamicCount];
    
    NSString *count = [friendHelp DynamicComments];
    
    if ( dynamicString.length != 0 ) {
        
        self.m_dynamicString = dynamicString;
        
    }else{
        
        self.m_dynamicString = @"0";
    }
    
    // 评论的个数
    if ( count.length != 0 ) {
        
        self.m_DynamicCommentsString = count;
        
    }else{
        
        self.m_DynamicCommentsString = @"0";
    }
    
    
    // 请求红点的接口
    [self requestSubmitRedDian];
   
    self.mWidgetController.readerDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    // 解决图片选择后出现的问题
//    if ( self.isChooseScanImage ) {
//
//        self.isChooseScanImage = NO;
//    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
//    return 4;
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section ==0) {
        return 2;
    }else if (section ==1){
        return 3;
    }return 1;
    

    
//    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if ( indexPath.section == 0 ) {
            
            if ( indexPath.row == 0 ) {
                // 头像
                UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 70, 10, 30, 30)];
                
                imgV.backgroundColor = [UIColor clearColor];
                
                imgV.tag = 101;
                
                [cell addSubview:imgV];
                // 红点
                UIImageView *imgVV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth - 45, 6, 10, 10)];
                
                imgVV.backgroundColor = [UIColor clearColor];
                
                imgVV.image = [UIImage imageNamed:@"number_bg.png"];
                
                imgVV.tag = 102;
                
                [cell addSubview:imgVV];
                
                // 添加
                UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake( 110, 8, 33, 33)];
                
                imgV2.backgroundColor = [UIColor clearColor];
                
                imgV2.image = [UIImage imageNamed:@"number_bg.png"];
                
                imgV2.tag = 103;
                
                [cell addSubview:imgV2];
                
                // 有新评论的数字
                UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(109, 5, 33, 33)];
                
                numLabel.backgroundColor = [UIColor clearColor];
                
                numLabel.textAlignment = NSTextAlignmentCenter;
                
                numLabel.textColor = [UIColor whiteColor];
                
                numLabel.font = [UIFont systemFontOfSize:12.0f];
                
                numLabel.text = @"1";
                
                numLabel.tag = 104;
                
                [cell addSubview:numLabel];
                
                imgV.hidden = YES;
                imgVV.hidden = YES;
                imgV2.hidden = YES;
                numLabel.hidden = YES;

                
            }
        }
        
        
    }

    if ( indexPath.section == 0 ) {
        
        
        if ( indexPath.row == 0 ) {
            
            cell.textLabel.text = @"朋友圈";
            
            cell.imageView.image = [UIImage imageNamed:@"f1.png"];
            
            if ( self.RedTipCnt.count != 0 ) {
                
                UIImageView *img = (UIImageView *)[cell viewWithTag:101];
                UIImageView *img1 = (UIImageView *)[cell viewWithTag:102];
                UIImageView *img2 = (UIImageView *)[cell viewWithTag:103];
                UILabel *label = (UILabel *)[cell viewWithTag:104];
                
                // 判断数据库中的数据是否和请求下来的数据相同
                NSString *string = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"DynamicList"]];
                
                NSString *countString = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"DynamicComments"]];
                
                // 评论的个数的显示
                if ( [self.m_DynamicCommentsString isEqualToString:countString] ) {
                    
                    img2.hidden = YES;
                    label.hidden = YES;
                    
                }else{
                    
                    // 如果这两个值不同时，如果服务器返回的数据等于0时，隐藏数字显示的控件
                    if ( [countString isEqualToString:@"0"] ) {
                        
                        img2.hidden = YES;
                        label.hidden = YES;
                        
                    }else{

                        img2.hidden = NO;
                        label.hidden = NO;
                        
                        label.text = [NSString stringWithFormat:@"%@",countString];
                    }
                    
                }
                
                // 动态的红点显示
                if ( [self.m_dynamicString isEqualToString:string] ) {
                    
                    img.hidden = YES;
                    img1.hidden = YES;
                    
                }else{
                    
                    // 服务端请求下来的数据和登录的用户的数据进行比较,如果最后更新的数据和登录的用户的数据相同的话，则不显示动态红点，如果不相同的话则显示动态的红点
                    NSString *memberId = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"MemberId"]];
                    
                    NSString *string = [NSString stringWithFormat:@"%@",[CommonUtil getValueByKey:MEMBER_ID]];
                    
                    if ( ![memberId isEqualToString:string] ) {
                        
                        img.hidden = NO;
                        img1.hidden = NO;
                        
                        // 获取图片
                        NSString *path = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"PhotoMid"]];
                        
                        [img setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                                   placeholderImage:[UIImage imageNamed:@"moren.png"]
                                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                //                                                 cell.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                
                                                img.image = image;
                                                
                                                img.contentMode = UIViewContentModeScaleAspectFit;
                                            }
                         
                                            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                
                                            }];
                        
                        
                    }else{
                        
                        img.hidden = YES;
                        img1.hidden = YES;
                    }
                    
                }

            }
            
            
            
        }
        
        
        if ( indexPath.row == 1 ) {
            
            cell.textLabel.text = @"扫一扫";
            
            cell.imageView.image = [UIImage imageNamed:@"f2.png"];
            
            
        }

    }else if( indexPath.section == 1 ) {
        
        if ( indexPath.row == 0 ) {
            
//            cell.textLabel.text = @"会员聚会";
//            
//            cell.imageView.image = [UIImage imageNamed:@"f5.png"];
            
            
            cell.textLabel.text = @"酒店";
            
            cell.imageView.image = [UIImage imageNamed:@"hotel.png"];
            
        }
        
        
        if ( indexPath.row == 1 ) {
            
//            cell.textLabel.text = @"商户活动";
//            
//            cell.imageView.image = [UIImage imageNamed:@"f4.png"];
            
            
            cell.textLabel.text = @"机票";
            
            cell.imageView.image = [UIImage imageNamed:@"fir.png"];

            
        }
        
        
        if ( indexPath.row == 2 ) {

            cell.textLabel.text = @"火车票";
            
            cell.imageView.image = [UIImage imageNamed:@"train.png"];
            
            
        }
        
    }
    
    else if ( indexPath.section == 2 ){
        
        if ( indexPath.row == 0 ) {
            
            cell.textLabel.text = @"景点门票";
            
            cell.imageView.image = [UIImage imageNamed:@"scener.png"];
            
            
        }
        
    }
    
    /*else if( indexPath.section == 2 ) {
        
        if ( indexPath.row == 0 ) {
            
            cell.textLabel.text = @"酒店";
            
            cell.imageView.image = [UIImage imageNamed:@"f5.png"];
            
            
        }
        
        
    }
    
    else if( indexPath.section == 3 ) {
        
        if ( indexPath.row == 0 ) {
            
            cell.textLabel.text = @"机票";
            
            cell.imageView.image = [UIImage imageNamed:@"f5.png"];
            
            
        }
    }
     
     */

    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    

    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ( indexPath.section == 0 ) {
        
        if ( indexPath.row == 0 ) {
            
            // 更新红点的数据保存到数据库中  DynamicComments
            [friendHelp updateDynamictCount:[self.RedTipCnt objectForKey:@"DynamicList"]withDynamicComments:@"0"];
            
            NSString *countString = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"DynamicComments"]];
            
            NSLog(@"CommentPhotoMid = %@",[self.RedTipCnt objectForKey:@"CommentPhotoMid"]);
            
            NSString *path = [NSString stringWithFormat:@"%@",[self.RedTipCnt objectForKey:@"CommentPhotoMid"]];
            
            if ( path.length != 0 ) {
                
                // 保存头像
                [CommonUtil addValue:path andKey:CommentPhotoMid];
                
            }
            
            NSLog(@"countString = %@",countString);
            
            // 保存起来评论的数据
            if ( ![countString isEqualToString:@"(null)"] ) {
                
                [CommonUtil addValue:countString andKey:DynamicComments];

            }else{
                
                [CommonUtil addValue:@"0" andKey:DynamicComments];

            }
            
            // 进入朋友圈
            DynamicViewController *VC = [DynamicViewController shareobject];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
        if ( indexPath.row == 1 ) {
            
            [self hideTabBar:YES];
            // 进入扫一扫
            ZBarReaderViewController *reader = [ZBarReaderViewController new];
            
            reader.readerDelegate = self;
            reader.sourceType = UIImagePickerControllerSourceTypeCamera;
            reader.supportedOrientationsMask = ZBarOrientationMaskAll;
            reader.showsZBarControls = NO;
            reader.wantsFullScreenLayout = NO;
            ZBarImageScanner *scanner = reader.scanner;

            [scanner setSymbology: ZBAR_I25
                           config: ZBAR_CFG_ENABLE
                               to: 0];

            // 设置导航栏的标题和返回的按钮
            UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
            [_button setFrame:CGRectMake(0, 0, 25, 25)];
            _button.backgroundColor = [UIColor clearColor];
            [_button setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
            [_button addTarget:self action:@selector(leftClicked) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
            [reader.navigationItem setLeftBarButtonItem:_barButton];
            
            
            UIButton *r_button = [UIButton buttonWithType:UIButtonTypeCustom];
            [r_button setFrame:CGRectMake(0, 0, 50, 29)];
            r_button.backgroundColor = [UIColor clearColor];
            [r_button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [r_button setTitle:@"相册" forState:UIControlStateNormal];
            [r_button setBackgroundImage:[UIImage imageNamed:@"xxqd.png"] forState:UIControlStateNormal];
            [r_button addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
            
//            UIBarButtonItem *r_barButton = [[UIBarButtonItem alloc] initWithCustomView:r_button];
//            [reader.navigationItem setRightBarButtonItem:r_barButton];
        
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];;
            label.text = @"扫一扫";
            reader.navigationItem.titleView = label;
            
            [self ZbarViewdid:reader];
   
            [self.navigationController pushViewController:reader animated:YES];
            
   
        }

    }else if (indexPath.section == 1){
        
        if ( indexPath.row == 0 ) {
            // 会员活动
//            f_partyViewController *VC = [[f_partyViewController alloc]initWithNibName:@"f_partyViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];

            
            //携程酒店
//            CtriphotelViewController * VC = [[CtriphotelViewController alloc]initWithNibName:@"CtriphotelViewController" bundle:nil];
//            
//            [self.navigationController  pushViewController:VC animated:YES];

            
            Hotel_webViewController *VC = [[Hotel_webViewController alloc]initWithNibName:@"Hotel_webViewController" bundle:nil];
             [self.navigationController  pushViewController:VC animated:YES];
 
        }else if ( indexPath.row == 1 ){
            // 商户活动
//            f_activityViewController *VC = [[f_activityViewController alloc]initWithNibName:@"f_activityViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];
            
            // 进入机票的页面
//            FlightsViewController *VC = [[FlightsViewController alloc]initWithNibName:@"FlightsViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];

            //==============
            Fl_webViewController *VC = [[Fl_webViewController alloc]initWithNibName:@"Fl_webViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:NO];
            //==============

        }
        else if ( indexPath.row == 2 ){

            // 进入火车票的页面
            TrainwebViewController *VC = [[TrainwebViewController alloc]initWithNibName:@"TrainwebViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
            
        }
        
    }else if ( indexPath.section == 2 ){
        
        if ( indexPath.row == 0 ) {
            
            // 进入景区门票的页面
//            TicketsViewController *VC = [[TicketsViewController alloc]initWithNibName:@"TicketsViewController" bundle:nil];
//            [self.navigationController pushViewController:VC animated:YES];

            Sec_webViewController *VC = [[Sec_webViewController alloc]initWithNibName:@"Sec_webViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
        
        }
    }
    
   /* else if (indexPath.section == 2)
    {
        
        
        if ( indexPath.row == 0 ) {
            //携程旅游
//            // 判断网络是否存在
//            if ( ![self isConnectionAvailable] ) {
//                return;
//            }
//            CtripwebViewController * VC = [[CtripwebViewController alloc]initWithNibName:@"CtripwebViewController" bundle:nil];
//            VC.Ctrip_webstring = @"http://m.ctrip.com/webapp/hotel";
            
            CtriphotelViewController * VC = [[CtriphotelViewController alloc]initWithNibName:@"CtriphotelViewController" bundle:nil];

            [self.navigationController  pushViewController:VC animated:YES];
            
            
        }
        
    }
    
    else if ( indexPath.section == 3 ){
        
        if ( indexPath.row == 0 ) {
            
            // 进入机票的页面
            
            FlightsViewController *VC = [[FlightsViewController alloc]initWithNibName:@"FlightsViewController" bundle:nil];
            [self.navigationController pushViewController:VC animated:YES];
            
            
            // 动画效果
//            [UIView transitionWithView:self.navigationController.view
//                              duration:0.75
//                               options:UIViewAnimationOptionTransitionCurlUp
//                            animations:^{
//                                
//                                [self.navigationController pushViewController:VC animated:NO];
//                            
//                            }
//                            completion:nil];
        }
        
        
    }*/
}

- (void)leftClicked{
    
    [self hideTabBar:NO];
    
    [self.mWidgetController.navigationController popViewControllerAnimated:YES];
}

- (void)rightClicked{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
	
    [self presentModalViewController:picker animated:YES];
    
}

#pragma mark uiimagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (ISscaning) {
        return;
    }
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;

    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    // 当选择类型是图片
    if ([type isEqualToString:@"public.image"]) {
        [picker dismissModalViewControllerAnimated:YES];
        if (isIOS7) { // 判断是否是IOS7
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        }
        if ([[NSString stringWithFormat:@"%@",symbol.data] isEqualToString:@"(null)"]) {
            [SVProgressHUD showErrorWithStatus:@"未获取到二维码"];
            ISscaning = NO;
            return;
        }
    }
    
    ISscaning = YES;
    [self playSound];
    
    // 字符串是否以http://开头,如果不是则就表示是手机号；如果是，则是公众邀请码的一个链接，需截取其中的一个手机号
    if ( [symbol.data hasPrefix:@"http://"] || [symbol.data hasPrefix:@"https://"] || [symbol.data hasPrefix:@"www"] ) {
        // 判断result是否包含  @"inviteCode="，如果包含则表示是公众邀请码，否则进入响应的网页
        if ( [symbol.data rangeOfString:@"inviteCode="].location != NSNotFound ) {
            
            NSArray *array = [symbol.data componentsSeparatedByString:@"inviteCode="];
            
            NSString *string = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
            
            NSLog(@"string  = %@",string);
            
            // 扫描的公众码去获得手机号
            [self requestValidateString:string];
            
        }else{
            
            // 进入网页页面
            WebViewController *VC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
            VC.m_scanString = symbol.data;
            VC.m_typeString = @"1";

            [self.navigationController pushViewController:VC animated:YES];
            
        }
        
        
    }else{
        // 扫描得到的是手机号,则相当于是调用搜索的接口
        [self requestPhoneString:symbol.data];
        
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

	[picker dismissModalViewControllerAnimated:YES];
    if (isIOS7) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}

- (void)requestSubmitRedDian{
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           nil];
    
    [httpClient request:@"RedTip.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            self.m_tableView.hidden = NO;
            
            self.RedTipCnt = [json valueForKey:@"RedTipCnt"];
            
            [self.m_tableView reloadData];
            
        } else {
            
            self.m_tableView.hidden = NO;
            
        }
        
    } failure:^(NSError *error) {
        
        self.m_tableView.hidden = NO;

    }];
}

// 根据扫描出来的公众邀请码获得手机号
- (void)requestValidateString:(NSString *)aValidateCode{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSString stringWithFormat:@"%@",aValidateCode],@"pubInvCode",
                           nil];
    
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"IsExist.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        
        if (success) {
            
            [SVProgressHUD dismiss];
      
            NSDictionary *dic = [json valueForKey:@"memberIsExistInfo"];
            
            // 进入搜索结果的页面
            ResultViewController *VC = [[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
            VC.m_typeString = @"2";
            VC.m_searchString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"PhoneNumber"]];

            [self.navigationController pushViewController:VC animated:YES];
            
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self hideTabBar:NO];

            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];

    }];

}

// 根据手机号进行搜索好友
- (void)requestPhoneString:(NSString *)aPhone{
        
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
                           [NSString stringWithFormat:@"%@",aPhone],@"content",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"PhoneSearch.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];

        if (success) {
            [SVProgressHUD dismiss];
            
            // 进入搜索结果的页面
            ResultViewController *VC = [[ResultViewController alloc]initWithNibName:@"ResultViewController" bundle:nil];
            VC.m_typeString = @"2";
            VC.m_searchString = [NSString stringWithFormat:@"%@",aPhone];

            [self.navigationController pushViewController:VC animated:YES];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
            
            [self hideTabBar:NO];

            [self.navigationController popViewControllerAnimated:YES];

        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];

    }];

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
