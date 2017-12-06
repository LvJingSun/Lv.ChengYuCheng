//
//  HH_advertListViewController.m
//  HuiHui
//
//  Created by mac on 15-4-17.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "HH_advertListViewController.h"

#import "HH_AdvertViewController.h"

#import "FirstListCell.h"

@interface HH_advertListViewController ()<UIActionSheetDelegate> {

    NSString *guanggaoID;
    
}

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@end

@implementation HH_advertListViewController

@synthesize m_adList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        m_adList = [[NSMutableArray alloc]initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"广告列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"新增广告" action:@selector(addAdvert)];
    
    // 隐藏提示的label
    self.m_emptyLabel.hidden = YES;
    
    // 请求数据
    [self advListRequest];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    
    longPress.minimumPressDuration = 1.0;
    
    [self.m_tableView addGestureRecognizer:longPress];
    
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture {

    CGPoint p = [gesture locationInView:self.m_tableView];
    
    NSIndexPath *indexpath = [self.m_tableView indexPathForRowAtPoint:p];
    
    NSDictionary *dic = [self.m_adList objectAtIndex:indexpath.row];
    
    if(gesture.state == UIGestureRecognizerStateBegan) {
    
            if ([dic[@"Type"] isEqualToString:@"gldad"] && [dic[@"Isdefault"] isEqualToString:@"0"]) {
                
                guanggaoID = dic[@"AppMctIndexID"];
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"设置为默认广告？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确认" otherButtonTitles:nil, nil];
        
        [sheet showInView:self.m_tableView];
        
            }
    
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    switch (buttonIndex) {
        case 0:
        {
        
            [self changeDefault];
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)changeDefault {

    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }

    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           guanggaoID, @"appMctIndexID",
                           nil];
    
    NSLog(@"%@",param);
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"ADSet_quanfanfu.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD showSuccessWithStatus:[json valueForKey:@"msg"]];
            
            [self advListRequest];
            
        } else {
            
            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD showErrorWithStatus:msg];
            
        }
        
    } failure:^(NSError *error) {

        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
    }];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
    
    
    NSString *advertsKey = [CommonUtil getValueByKey:AdvertsKey];
    
    if ( [advertsKey isEqualToString:@"1"] ) {
        
        [CommonUtil addValue:@"0" andKey:AdvertsKey];
        
        // 请求数据进行刷新页面
        [self advListRequest];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftClicked{
    
    [self goBack];
}

- (void)addAdvert{
    
    // 进入广告新增的页面
    HH_AdvertViewController *VC = [[HH_AdvertViewController alloc]initWithNibName:@"HH_AdvertViewController" bundle:nil];
    VC.m_type = @"1";
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.m_adList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"AdvertListCellIdentifier";
   
    AdvertListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
      
        NSArray *nib = [[NSBundle mainBundle]
                           loadNibNamed:@"FirstListCell" owner:self options:nil];
        cell = (AdvertListCell *)[nib objectAtIndex:1];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//cell 不被选择
        
        // 设置图片的透明度
        cell.m_backImgV.backgroundColor = [UIColor blackColor];
        cell.m_backImgV.alpha = 0.4f;
        
    }
    
    // 赋值
    
    
    if ( self.m_adList.count != 0 ) {
        
        NSDictionary *dic = [self.m_adList objectAtIndex:indexPath.row];
        
//        cell.m_imageView.backgroundColor = [UIColor redColor];
        
        if ([dic[@"Type"] isEqualToString:@"gldad"]) {
            
            if ([dic[@"Isdefault"] isEqualToString:@"1"]) {
                
                cell.m_title.text = [NSString stringWithFormat:@"全返付广告——%@ (默认)",[dic objectForKey:@"Title"]];
                
            }else {
            
                cell.m_title.text = [NSString stringWithFormat:@"全返付广告——%@",[dic objectForKey:@"Title"]];
                
            }
            
        }else {
        
            cell.m_title.text = [NSString stringWithFormat:@"首页广告——%@",[dic objectForKey:@"Title"]];
            
        }

        [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"OldImgUrl"]]];
    
    }
 
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 点击进入广告详情的页面
    NSMutableDictionary *dic = [self.m_adList objectAtIndex:indexPath.row];
    
    HH_AdvertViewController *VC = [[HH_AdvertViewController alloc]initWithNibName:@"HH_AdvertViewController" bundle:nil];
    VC.m_type = @"2";
    VC.m_dic = dic;
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - 请求数据
- (void)advListRequest{
    
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        
        return;
    }
    
    NSString *merchantId = [CommonUtil getValueByKey:MERCHANTID];
    //    NSString *key = [CommonUtil getServerKey];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
        NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                               merchantId, @"merchantId",
                               nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"UpAdList_2.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            
            [SVProgressHUD dismiss];
            
            NSLog(@"json = %@",json);
            
            self.m_adList = [json valueForKey:@"UpAdModelList"];
            
            if ( self.m_adList.count != 0 ) {
                
                self.m_emptyLabel.hidden = YES;
                self.m_tableView.hidden = NO;
                // 刷新列表
                [self.m_tableView reloadData];
                
            }else{
                
                self.m_emptyLabel.hidden = NO;
                self.m_tableView.hidden = YES;
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


@end
