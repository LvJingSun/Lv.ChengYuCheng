//
//  MerchantDetailViewController.m
//  baozhifu
//
//  Created by mac on 13-12-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MerchantDetailViewController.h"

#import "ProductListViewController.h"

#import "ShopListViewController.h"

#import "MapViewController.h"

#import "CommentViewController.h"

#import "EvaluateViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "UIImageView+AFNetworking.h"

#import "AppHttpClient.h"

@interface MerchantDetailViewController ()

@property (strong, nonatomic) IBOutlet UIView *m_footerView;

@property (strong, nonatomic) IBOutlet UIView *m_headerView;

@property (weak, nonatomic) IBOutlet UIImageView *m_imageView;

@property (weak, nonatomic) IBOutlet UILabel *m_nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *m_subTitleLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


// 感兴趣
- (IBAction)InterestClicked:(id)sender;
// 说两句
- (IBAction)saidClicked:(id)sender;
// 评价
- (IBAction)commentClicked:(id)sender;


@end

@implementation MerchantDetailViewController

@synthesize m_merchantDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_merchantDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if ( isIOS7 ) {
        
        // tableView的线往右移了，添加这代码可以填充
        if ([self.m_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.m_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    // 设置tableView的headerView和footerView
    self.m_tableView.tableHeaderView = self.m_headerView;
    
    self.m_tableView.tableFooterView = self.m_footerView;
    
    [self setTitle:@"商户详情"];
    
    // 根据来自于哪个页面来判断右上角的按钮触发的事件 1表示来自于商户列表 - 进行关注 2表示来自于我的底盘 - 取消关注
    if ( [self.m_typeString isEqualToString:@"1"] ) {
        
        [self setRightButtonWithNormalImage:@"like.png" action:@selector(rightClicked)];
        
    }else if ( [self.m_typeString isEqualToString:@"2"] ) {
        
        UIButton *_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setFrame:CGRectMake(0, 0, 50, 29)];
        _button.backgroundColor = [UIColor clearColor];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_button setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        
        [_button addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *_barButton = [[UIBarButtonItem alloc] initWithCustomView:_button];
        [self.navigationItem setRightBarButtonItem:_barButton];
        
        self.m_titleBtn = _button;
        
        
    }else{
        
        
    }
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    self.m_tableView.hidden = YES;
    
    // 请求数据
    [self requestSubmit];
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
    [self setM_footerView:nil];
    [self setM_headerView:nil];
    [self setM_imageView:nil];
    [self setM_nameLabel:nil];
    [self setM_subTitleLabel:nil];
    [self setM_tableView:nil];
    [super viewDidUnload];
}


- (void)leftClicked{
    
    [self goBack];
}

- (void)rightClicked{
   
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
                           [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]], @"merchantId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantAttentionAdd.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            // [SVProgressHUD dismiss];
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
          
            // 从我的地盘进入可进行取消关注和关注的功能
            if ( [self.m_typeString isEqualToString:@"2"] ) {
                
                // 关注成功后按钮响应取消关注的事件
                [self.m_titleBtn removeTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
                
                [self.m_titleBtn addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
                
                
                // 保存数据来判断返回上一级时是否要重新请求商户列表的数据
                
                [CommonUtil addValue:@"0" andKey:kMerchantKey];


            }else{
                
                // 保存数据来判断返回上一级时是否要重新请求商户列表的数据
                
                [CommonUtil addValue:@"1" andKey:kMerchantKey];

            }
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}

// 取消对商户的关注请求数据
- (void)cancelAttentionRequest{
    
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
                           [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]], @"merchantId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantAttentionCancel.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            // [SVProgressHUD dismiss];
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showSuccessWithStatus:msg];
            
            // 取消成功后按钮响应关注商户的事件
            [self.m_titleBtn removeTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
            
            [self.m_titleBtn addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
            
            // 保存数据来判断返回上一级时是否要重新请求商户列表的数据
            
            [CommonUtil addValue:@"1" andKey:kMerchantKey];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
    
}


// 请求数据
- (void)requestSubmit{
    
    self.m_MemberRelationsId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MerchantShopId"]];
        
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:

                                  [NSString stringWithFormat:@"%@",self.m_MemberRelationsId],   @"merchantShopId",
                                  nil];
        
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantDescription.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            self.m_merchantDic = [json valueForKey:@"Merchant"];
            
            self.m_tableView.hidden = NO;
            
            self.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Allname"]];
            self.m_subTitleLabel.text = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Briefintro"]];
            
            CGSize size = [self.m_subTitleLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(238, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            self.m_subTitleLabel.frame = CGRectMake(self.m_subTitleLabel.frame.origin.x, self.m_subTitleLabel.frame.origin.y, 238, size.height);
            
            self.m_headerView.frame = CGRectMake(self.m_headerView.frame.origin.x, self.m_headerView.frame.origin.y, self.m_headerView.frame.size.width, 45 + size.height + 13);
            
            // 获取图片
            NSString *path = [self.m_merchantDic objectForKey:@"LogoSmlUrl"];
            
            [self.m_imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                                    placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                 self.m_imageView.image = [CommonUtil scaleImage:image toSize:CGSizeMake(68, 68)];
                                                 
                                             }
                                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                 
                                             }];
            
            // 设置tableView的headerView和footerView
            self.m_tableView.tableHeaderView = self.m_headerView;
            
            self.m_tableView.tableFooterView = self.m_footerView;
            
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
        
        
    } failure:^(NSError *error) {
        
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        //self.tableView.pullLastRefreshDate = [NSDate date];
        
    }];
    
}

// 判断是否在此商户下购买过商品
- (void)requestBuy{
    
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
                           [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]], @"merchantId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantCommentCheck.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            // 如果成功则说明购买过，就直接进入评价的页面
            //            NSString *msg = [json valueForKey:@"msg"];
            
            // 进入评价的页面
            EvaluateViewController *VC = [[EvaluateViewController alloc]initWithNibName:@"EvaluateViewController" bundle:nil];
            VC.m_typeString = @"2";
            VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];
            [self.navigationController pushViewController:VC animated:YES];
            
            
            
        } else {
            // 如果不成功则说明没购买过，就直接跳出错误的提示
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

// 取消关注
- (void)cancelAttention{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"您确定取消对该商户的关注？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    alertView.tag = 14203;
    [alertView show];
    
  
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ( alertView.tag == 14203 ) {
        
        if ( buttonIndex == 1 ) {
            // 取消关注请求数据
            [self cancelAttentionRequest];
            
        }
    }
    
}

#pragma mark - UITableVIewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {

        cell = (UITableViewCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    if ( indexPath.row == 0 ) {
        
        cell.textLabel.text = @"商品";
        
    }else  if ( indexPath.row == 1 ) {
        
        cell.textLabel.text = @"店铺";
        
    }else  if ( indexPath.row == 2 ) {
        
        cell.textLabel.text = @"位置";

    }else  if ( indexPath.row == 3 ) {
        
        cell.textLabel.text = @"评价";

    }else{
        

        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ( indexPath.row == 0 ) {
        
        // 进入商品列表
        ProductListViewController *VC = [[ProductListViewController alloc]initWithNibName:@"ProductListViewController" bundle:nil];
        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];
        VC.m_merchantShopId = [NSString stringWithFormat:@"%@",[self.m_items objectForKey:@"MerchantShopId"]];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ( indexPath.row == 1 ){
        
//        // 进入活动
//        ActivityViewController *VC = [[ActivityViewController alloc]initWithNibName:@"ActivityViewController" bundle:nil];
//        [self.navigationController pushViewController:VC animated:YES];
        
        // 进入店铺列表
        ShopListViewController *VC = [[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
        VC.m_typeString = @"2";
        VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];

        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else if ( indexPath.row == 2 ){
        
       if ( [self.m_typeString isEqualToString:@"2"] ) {
            
            // 将数据添加到数组里面- 从关注的商户列表进来
            [self.m_items addEntriesFromDictionary:[NSDictionary dictionaryWithDictionary:self.m_merchantDic]];
       }else{
           
           
       }
        
        // 进入位置
        MapViewController *VC = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
        VC.item = self.m_items;
        VC.m_shopString = @"2";
        [self.navigationController pushViewController:VC animated:YES];

        
    }else if ( indexPath.row == 3 ){
        // 进入评价的页面
        CommentViewController *VC = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
         VC.m_typeString = @"2";
        VC.m_serviceId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];
        [self.navigationController pushViewController:VC animated:YES];
        
        
    }else{
       
        
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

- (IBAction)InterestClicked:(id)sender {
    
    //  判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"memberId",
                           key,   @"key",
                           [self.m_items objectForKey:@"MerchantShopId"], @"merchantShopId",
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MerchantShopInterested.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showSuccessWithStatus:msg];
            
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];

}

- (IBAction)saidClicked:(id)sender {
    
    // 说两句
    EvaluateViewController *VC = [[EvaluateViewController alloc]initWithNibName:@"EvaluateViewController" bundle:nil];
    VC.m_typeString = @"1";
    VC.m_merchantId = [NSString stringWithFormat:@"%@",[self.m_merchantDic objectForKey:@"Merchantid"]];
    [self.navigationController pushViewController:VC animated:YES];
  
}

- (IBAction)commentClicked:(id)sender {

    // 判断是否在此商户下购买过商品
    [self requestBuy];
}


@end
