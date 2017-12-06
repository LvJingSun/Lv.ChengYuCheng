//
//  FriendsViewController.m
//  HuiHui
//
//  Created by mac on 13-11-20.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "FriendsViewController.h"

#import "FriendsCell.h"

#import "AddFriendViewController.h"

#import "UserInformationViewController.h"

#import "NewFriendsViewController.h"

#import "MerchantDetailViewController.h"

#import "InviteResultViewController.h"

#import "InviteViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

@synthesize m_friendsArray;

@synthesize m_MerchantArray;

@synthesize m_searchArray;

@synthesize m_InviteArray;

@synthesize m_typeArray;

@synthesize flagDictinary;

@synthesize isEnterSecondPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_MerchantArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_searchArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_typeArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        self.m_isSearching = NO;
        
        flagDictinary = [[NSMutableDictionary alloc]initWithCapacity:0];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"圈子"];

    [self setRightButtonWithNormalImage:@"add.png" action:@selector(rightClicked)];
      
    self.m_searchBar.showsCancelButton = NO;
    
    // 设置searchBar上的取消按钮的背景
    for(id cc in [self.m_searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    
    // 初始化每一个tableview的所有分区的开关状态字典
    [flagDictinary setObject:[NSMutableSet set] forKey:[NSNumber numberWithInt:self.m_tableView.tag]];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear: animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.isEnterSecondPage = NO;
    
    // 请求数据
    [self friendsRequest];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if ( self.isEnterSecondPage ) {
        
        self.m_tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 49);
    }else{
        
        self.m_tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClicked{
    
    [self.m_searchBar resignFirstResponder];

    // 添加好友
    AddFriendViewController *VC = [[AddFriendViewController alloc]initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)friendsRequest{

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
                           nil];
    [SVProgressHUD showWithStatus:@"数据加载中"];
    [httpClient request:@"MemberInviteList.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            //            NSString *msg = [json valueForKey:@"msg"];
            
            [SVProgressHUD dismiss];
            
            [self.m_friendsArray removeAllObjects];
            
            [self.m_MerchantArray removeAllObjects];
            
            [self.m_InviteArray removeAllObjects];
            
            self.m_friendsArray = [json valueForKey:@"memberJoinedInvite"];
            self.m_MerchantArray = [json valueForKey:@"memberRelationsInfo"];
            self.m_InviteArray = [json valueForKey:@"memberInvitationInvite"];
            
            // 刷新列表
            [self.m_tableView reloadData];
          
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        //NSLog(@"failed:%@", error);
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

- (NSInteger)rowCell{
    
    if ( self.m_friendsArray.count != 0 && self.m_MerchantArray.count != 0 && self.m_InviteArray.count != 0 ) {
        
        return 0;
        
    }else if (self.m_friendsArray.count == 0 && self.m_MerchantArray.count != 0 && self.m_InviteArray.count != 0 ){
        
        return 1;
        
    }else if (self.m_friendsArray.count == 0 && self.m_MerchantArray.count == 0 && self.m_InviteArray.count != 0 ){
        
        return 2;
        
    }else if (self.m_friendsArray.count == 0 && self.m_MerchantArray.count != 0 && self.m_InviteArray.count == 0 ){
        
        return 3;
        
    }else if (self.m_friendsArray.count != 0 && self.m_MerchantArray.count == 0 && self.m_InviteArray.count != 0 ){
        
        return 4;
        
    }else if (self.m_friendsArray.count != 0 && self.m_MerchantArray.count == 0 && self.m_InviteArray.count == 0 ){
        
        return 5;
        
    }else if (self.m_friendsArray.count != 0 && self.m_MerchantArray.count != 0 && self.m_InviteArray.count == 0 ){
        
        return 6;
        
    }else if (self.m_friendsArray.count == 0 && self.m_MerchantArray.count == 0 && self.m_InviteArray.count == 0 ){
        
        return 7;
        
    }else{
        
        return 8;
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ( !self.m_isSearching ) {
        
        return 4;
             /*
        NSInteger index = [self rowCell];
   
        switch (index) { 
            case 0:
                return 4;
                break;
            case 1:
                return 3;
                break;
            case 2:
                return 2;
                break;
            case 3:
                return 2;
                break;
            case 4:
                return 3;
                break;
            case 5:
                return 2;
                break;
            case 6:
                return 3;
                break;
            case 7:
                return 1;
                break;
            case 8:
                return 0;
                break;
                
            default:
                
                return 0;
                break;
        }
        
        */
                
    }else{
        
        return 1;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ( !self.m_isSearching ) {
        
        int count = [self numberOfRowsInSection:tableView Section:section];
        
        return count;
        /*
//        NSInteger index = [self rowCell];
//        
//        switch (index) {
//            case 0:
//            {
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else if (section == 1 ){
//                    
//                    return self.m_MerchantArray.count;
//                    
//                }else if (section == 2 ){
//                    
//                    return self.m_friendsArray.count;
//                    
//                } else{
//                    
//                    return self.m_InviteArray.count;
//                }
//                
//                
//            }
//                
//                break;
//            case 1:
//            {
//                
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else if (section == 1 ){
//                    
//                    return self.m_MerchantArray.count;
//                    
//                }else{
//                    
//                    return self.m_InviteArray.count;
//                    
//                }
//            }
//                break;
//            case 2:
//            {
//                
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else{
//                    
//                    return self.m_InviteArray.count;
//                    
//                }
//            }
//                break;
//            case 3:
//            {
//                
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else{
//                    
//                    return self.m_MerchantArray.count;
//                    
//                }
//                
//            }
//                break;
//            case 4:
//            {
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else if (section == 1 ){
//                    
//                    return self.m_friendsArray.count;
//                    
//                }else{
//                    
//                    return self.m_InviteArray.count;
//                    
//                }
//                
//            }
//                break;
//            case 5:
//            {
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else{
//                    
//                    return self.m_friendsArray.count;
//                    
//                }
//                
//            }
//                break;
//            case 6:
//            {
//                if ( section == 0 ) {
//                    
//                    return 1;
//                    
//                }else if (section == 1 ){
//                    
//                    return self.m_MerchantArray.count;
//                    
//                }else{
//                    
//                    return self.m_friendsArray.count;
//                    
//                }
//                
//            }
//                break;
//            case 7:
//                return 1;
//                break;
//            case 8:
//                return 0;
//                break;
//                
//            default:
//                
//                return 0;
//                break;
//        }
        
        */
        
    }else{
        
        if ( self.m_searchArray.count != 0 ) {
            
             return self.m_searchArray.count;
            
        }else{
            
            return 1;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( !self.m_isSearching ) {
        
        UITableViewCell *cell = [self CommonTableView:tableView cellForRowAtIndexPath:indexPath];
        
        return cell;
        
    }else{

                
        if ( self.m_searchArray.count != 0 ) {
            
            static NSString *cellIdentifier = @"FriendsCellIdentifier";
            
            FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
                
                cell = (FriendsCell *)[nib objectAtIndex:0];
                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
                
            }
            
            cell.m_imageBtn.hidden = YES;

            cell.m_imageView.image = [UIImage imageNamed:@"moren.png"];
            
            cell.m_nameLabel.text = [self.m_searchArray objectAtIndex:indexPath.row];
            
            return cell;
            
        }else{
            
            static NSString *cellIdentifier = @"CellIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if ( cell == nil ) {
                
                
                cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            
            cell.textLabel.text = @"暂无您搜索的内容";
            
            cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
            
            
            return cell;
        }
       
    }
}

- (UITableViewCell *)CommonTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FriendsCellIdentifier";
    
    FriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FriendsCell" owner:self options:nil];
        
        cell = (FriendsCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    
  /*  switch (index) {
        case 0:
        {
            if ( indexPath.section == 0 ) {
              
                                 
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;

                
            }else if (indexPath.section == 1 ){
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MerchantArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
          
            
            }else if (indexPath.section == 2 ){
                
                                 
                cell.m_nameLabel.text = [self.m_friendsArray objectAtIndex:indexPath.row];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            } else{
                
                                 
                cell.m_nameLabel.text = [self.m_InviteArray objectAtIndex:indexPath.row];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
            }
            
            
        }
            
            break;
        case 1:
        {
            
            if ( indexPath.section == 0 ) {
                
                                 
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;

                
            }else if (indexPath.section == 1 ){
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MerchantArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            }else{
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_InviteArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            }
        }
            break;
        case 2:
        {
            
            if ( indexPath.section == 0 ) {
                
                                 
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            }else{
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_InviteArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
            }
        }
            break;
        case 3:
        {
            
            if ( indexPath.section == 0 ) {
                
                                 
                cell.m_nameLabel.text = @"新的朋友";

                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            }else{
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MerchantArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
            }
            
        }
            break;
        case 4:
        {
            if ( indexPath.section == 0 ) {
                
                                 
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;

                
            }else if (indexPath.section == 1 ){
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_friendsArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            }else{
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_InviteArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
            }
            
        }
            break;
        case 5:
        {
            if ( indexPath.section == 0 ) {
                
                                 
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;

                
            }else{
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_friendsArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
            }
            
        }
            break;
        case 6:
        {
            if ( indexPath.section == 0 ) {
                
                                 
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;

                
            }else if (indexPath.section == 1 ){
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_MerchantArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
                
            }else{
                
                                 
                cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[self.m_friendsArray objectAtIndex:indexPath.row]];
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;
            }
            
        }
            break;
        case 7:
        {
            
            if ( indexPath.section == 0 ) {
                
                
                cell.m_nameLabel.text = @"新的朋友";
                
                cell.m_bgImgV.hidden = YES;
                
                cell.m_numberLabel.hidden = YES;

            }
        }
            break;
        case 8:
        
            break;
            
        default:
            
            break;
    }*/
    
    if ( indexPath.section == 0 ) {
        
        cell.m_imageView.image = [UIImage imageNamed:@"new_friend.png"];

        cell.m_nameLabel.text = @"新的朋友";
        
        cell.m_inviteNameLabel.hidden = YES;
        
        cell.m_nameLabel.hidden = NO;
        
        cell.m_imageView.hidden = NO;
        
        cell.m_statusLabel.hidden = YES;
        
    }else if (indexPath.section == 1 ){
        
        
        if ( self.m_MerchantArray.count != 0 ) {
            
            cell.m_inviteNameLabel.hidden = YES;
            
            cell.m_nameLabel.hidden = NO;
            
            cell.m_imageView.hidden = NO;
            
            cell.m_statusLabel.hidden = YES;
            
            NSDictionary *dic = [self.m_MerchantArray objectAtIndex:indexPath.row];
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MctName"]];
            
            [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MerchantPic"]]];
 
            
        }
              
    }else if (indexPath.section == 2 ){
        
        if ( self.m_friendsArray.count != 0 ) {
            
            cell.m_inviteNameLabel.hidden = YES;
            
            cell.m_nameLabel.hidden = NO;
            
            cell.m_imageView.hidden = NO;
            
            cell.m_statusLabel.hidden = YES;
            
            NSDictionary *dic = [self.m_friendsArray objectAtIndex:indexPath.row];
            
            cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
            
            [cell setImageView:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]]];
 
        }
       
    } else{
        
        if ( self.m_InviteArray.count != 0 ) {
            
            cell.m_inviteNameLabel.hidden = NO;
            
            cell.m_nameLabel.hidden = YES;
            
            cell.m_imageView.hidden = YES;
            
            cell.m_statusLabel.hidden = NO;
            
            NSDictionary *dic = [self.m_InviteArray objectAtIndex:indexPath.row];
            
            cell.m_inviteNameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteName"]];
            
            // 判断邀请中好友是否已过期的标志 Joined 表示已过期  Invitation 邀请中
            if ( [[dic objectForKey:@"InviteStatus"] isEqualToString:@"Joined"] ) {
                
                cell.m_statusLabel.text = @"已过期";
                
            }else if ( [[dic objectForKey:@"InviteStatus"] isEqualToString:@"Invitation"] ) {
                
                cell.m_statusLabel.text = @"邀请中";
                
            }else{
                
                cell.m_statusLabel.text = @"";
            }

            
        }
     
    }

    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_bg_sousuo.png"]];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 310, 23)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:16.0f];
    [view addSubview:label];
    
    
    // button 
    UIButton *l_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 45)];
    l_button.backgroundColor = [UIColor clearColor];
    [l_button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    // ImageView
    
    self.m_imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 18, 16, 10)];
    self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
    self.m_imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 18, 16, 10)];
    self.m_imageView2.image = [UIImage imageNamed:@"bd_04@2x.png"];
    self.m_imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(290, 18, 16, 10)];
    self.m_imageView3.image = [UIImage imageNamed:@"bd_04@2x.png"];
    
    l_button.tag = section;
    [l_button addTarget:self action:@selector(headerClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:l_button];
    
    
    if ( !self.m_isSearching ) {
        
        if ( section == 0 ) {
            
            return nil;
            
        }else if (section == 1 ){
            
            label.text = @"关注商户（我的地盘）";
            [view addSubview:self.m_imageView1];
            return view;
            
        }else if (section == 2 ){
            
            label.text = @"我的好友";
            [view addSubview:self.m_imageView2];
            
            return view;
            
        } else{
            
            label.text = @"邀请中的好友";
            [view addSubview:self.m_imageView3];
            
            return view;
        }

        
//        NSInteger index = [self rowCell];
        
      /*  switch (index) {
            case 0:
            {
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else if (section == 1 ){
                    
                    label.text = @"关注商户（我的地盘）";
                    [view addSubview:self.m_imageView1];
                    return view;
                    
                }else if (section == 2 ){
                    
                    label.text = @"我的好友";
                    [view addSubview:self.m_imageView2];

                    return view;
                    
                } else{
                    
                    label.text = @"邀请中的好友";
                    [view addSubview:self.m_imageView3];

                    return view;
                }
                
                
            }
                
                break;
            case 1:
            {
                
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else if (section == 1 ){
                    
                    label.text = @"关注商户（我的地盘）";
                    [view addSubview:self.m_imageView1];

                    return view;
                    
                }else{
                    
                    label.text = @"邀请中的好友";
                    [view addSubview:self.m_imageView3];

                    return view;
                    
                }
            }
                break;
            case 2:
            {
                
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else{
                    
                    label.text = @"邀请中的好友";
                    [view addSubview:self.m_imageView3];

                    return view;
                    
                }
            }
                break;
            case 3:
            {
                
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else{
                    
                    label.text = @"关注商户（我的地盘）";
                    [view addSubview:self.m_imageView1];

                    return view;
                    
                }
                
            }
                break;
            case 4:
            {
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else if (section == 1 ){
                    
                    label.text = @"我的好友";
                    [view addSubview:self.m_imageView2];

                    return view;
                    
                }else{
                    
                    label.text = @"邀请中的好友";
                    [view addSubview:self.m_imageView3];

                    return view;
                    
                }
                
            }
                break;
            case 5:
            {
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else{
                    
                    label.text = @"我的好友";
                    [view addSubview:self.m_imageView2];

                    return view;
                    
                }
                
            }
                break;
            case 6:
            {
                if ( section == 0 ) {
                    
                    return nil;
                    
                }else if (section == 1 ){
                    
                    label.text = @"关注商户（我的地盘）";
                    [view addSubview:self.m_imageView1];

                    return view;
                    
                }else{
                    
                    label.text = @"我的好友";
                    [view addSubview:self.m_imageView2];

                    return view;
                    
                }
                
            }
                break;
            case 7:
                return nil;
                break;
            case 8:
                return nil;
                break;
                
            default:
                
                return nil;
                break;
        }*/

        
    }else{
        
        return nil;
        
    }
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.isEnterSecondPage = YES;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    if ( self.m_isSearching ) {
        // 搜索中的要根据某一字段来进行判断是属于哪一类型的来进入不同的子分类
        // 进入详细资料
        UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
        VC.m_typeString = @"2";
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        
        if ( indexPath.section == 0 ) {
            // 新朋友的列表
            if ( indexPath.row == 0 ) {
                
                NewFriendsViewController *VC = [[NewFriendsViewController alloc]initWithNibName:@"NewFriendsViewController" bundle:nil];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
        }else if ( indexPath.section == 1 ){
            
            NSMutableDictionary *dic = [self.m_MerchantArray objectAtIndex:indexPath.row];
            
            // 进入关注的商户详情
            MerchantDetailViewController *VC = [[MerchantDetailViewController alloc]initWithNibName:@"MerchantDetailViewController" bundle:nil];
            VC.m_typeString = @"2";
            VC.m_items = dic;
            [self.navigationController pushViewController:VC animated:YES];
        
        } else  if ( indexPath.section == 2 ){
            
            NSMutableDictionary *dic = [self.m_friendsArray objectAtIndex:indexPath.row];
            
            // 进入详细资料
            UserInformationViewController *VC = [[UserInformationViewController alloc]initWithNibName:@"UserInformationViewController" bundle:nil];
            VC.m_typeString = @"2";
            
            ///// 好友Id================
            VC.m_friendId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
            [self.navigationController pushViewController:VC animated:YES];
 
        }else{
            
            NSMutableDictionary *dic = [self.m_InviteArray objectAtIndex:indexPath.row];
            
            // 邀请中好友的页面
            if ( [[dic objectForKey:@"InviteStatus"] isEqualToString:@"Joined"] ) {
                // 重新邀请-已过期的状态
                InviteViewController *VC = [[InviteViewController alloc]initWithNibName:@"InviteViewController" bundle:nil];
                VC.m_dic = dic;
                VC.stringType = @"1";
                [self.navigationController pushViewController:VC animated:YES];
            
            }else{
                // 查看-未过期的状态
                InviteResultViewController *VC = [[InviteResultViewController alloc]initWithNibName:@"InviteResultViewController" bundle:nil];
                VC.message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InviteCodeView"]];
                VC.phone = [NSString stringWithFormat:@"%@",[dic objectForKey:@"InvitePhone"]];
                VC.m_type = @"2";
                [self.navigationController pushViewController:VC animated:YES];
            }
            
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( !self.m_isSearching ) {
        
        if ( section == 0 ) {
            
            return 0.0f;
            
        }else{
            
            return 45.0f;
        }
    }else{
        
        return 0.0f;
 
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

// 判断是否展开
- (BOOL)isSection:(int)section ExpandOfTableView:(UITableView*)tableView{

    BOOL result = NO;
    NSMutableSet *expandedSectionsSet = [flagDictinary objectForKey:[NSNumber numberWithInt:tableView.tag]];

    if ( [expandedSectionsSet containsObject:[NSNumber numberWithInt:section]] ) {
        result = YES;
    }

    return result;
}

// 展开的section保存到expandedSectionsSet里面
- (void)setSection:(int)section tableView:(UITableView*)tableView expand:(BOOL)expand{

    NSMutableSet *expandedSectionsSet = [flagDictinary objectForKey:[NSNumber numberWithInt:tableView.tag]];

    if ( expand ) {

        if ( ![expandedSectionsSet containsObject:[NSNumber numberWithInt:section]] ) {

            [expandedSectionsSet addObject:[NSNumber numberWithInt:section]];
        }

    }else{

        [expandedSectionsSet removeObject:[NSNumber numberWithInt:section]];

    }

}

// 返回行数
- (int)numberOfRowsInSection:(UITableView *)Tableview Section:(NSInteger)section{

    BOOL expand = [self isSection:section ExpandOfTableView:Tableview];

    if ( expand ) {
        
        if ( section == 0 ) {
            
            return 1;
            
        }else if (section == 1 ){
            
            return self.m_MerchantArray.count;
            
        }else if (section == 2 ){
            
            return self.m_friendsArray.count;
            
        } else{
            
            return self.m_InviteArray.count;
        }


//        NSInteger index = [self rowCell];
        
      /*  switch (index) {
            case 0:
            {
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else if (section == 1 ){
                    
                    return self.m_MerchantArray.count;
                    
                }else if (section == 2 ){
                    
                    return self.m_friendsArray.count;
                    
                } else{
                    
                    return self.m_InviteArray.count;
                }
                
                
            }
                
                break;
            case 1:
            {
                
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else if (section == 1 ){
                    
                    return self.m_MerchantArray.count;
                    
                }else{
                    
                    return self.m_InviteArray.count;
                    
                }
            }
                break;
            case 2:
            {
                
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else{
                    
                    return self.m_InviteArray.count;
                    
                }
            }
                break;
            case 3:
            {
                
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else{
                    
                    return self.m_MerchantArray.count;
                    
                }
                
            }
                break;
            case 4:
            {
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else if (section == 1 ){
                    
                    return self.m_friendsArray.count;
                    
                }else{
                    
                    return self.m_InviteArray.count;
                    
                }
                
            }
                break;
            case 5:
            {
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else{
                    
                    return self.m_friendsArray.count;
                    
                }
                
            }
                break;
            case 6:
            {
                if ( section == 0 ) {
                    
                    return 1;
                    
                }else if (section == 1 ){
                    
                    return self.m_MerchantArray.count;
                    
                }else{
                    
                    return self.m_friendsArray.count;
                    
                }
                
            }
                break;
            case 7:
                return 1;
                break;
            case 8:
                return 0;
                break;
                
            default:
                
                return 0;
                break;
        }*/
     
       
    }
    else {
        if ( section == 0 ) {
            
            return 1;
            
        }else{
            
            return 0;
        }
    }
}


#pragma mark - button click
-(void)headerClick:(id)sender{
    // button的tag值
    int sectionIndex = ((UIButton*)sender).tag;

    // bool值判断哪个section是展开还是合起来的
    BOOL expand = [self isSection:sectionIndex ExpandOfTableView:self.m_tableView];

    [self setSection:sectionIndex tableView:self.m_tableView expand:!expand];

    // 刷新tableView
    [self.m_tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];

    // 判断选中的是第几个区域来进行图片的动画
    if ( sectionIndex == 0 ) {

//        if ( expand ) {
//
//            self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];
//
//        }else{
//
//            self.m_imageView1.image = [UIImage imageNamed:@"bd_05@2x.png"];
//
//        }
    }else if ( sectionIndex == 1 ) {

        if ( expand ) {

            self.m_imageView1.image = [UIImage imageNamed:@"bd_04@2x.png"];

        }else{

            self.m_imageView1.image = [UIImage imageNamed:@"bd_05@2x.png"];

        }
    }else if ( sectionIndex == 2 ) {

        if ( expand ) {

            self.m_imageView2.image = [UIImage imageNamed:@"bd_04@2x.png"];

        }else{

            self.m_imageView2.image = [UIImage imageNamed:@"bd_05@2x.png"];

        }
    }else{
        
        if ( expand ) {
            
            self.m_imageView3.image = [UIImage imageNamed:@"bd_04@2x.png"];
            
        }else{
            
            self.m_imageView3.image = [UIImage imageNamed:@"bd_05@2x.png"];
            
        }
    }
}


#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    // textField进行改变的时候 搜索:将数组里的数据与m_searchBar.text进行比较,若存在,则存入搜索数组中
    // 先将数组里的数据remove,以存放新的数据
    [self.m_searchArray removeAllObjects];
    // 遍历整个数组
    for (NSString * obj in self.m_friendsArray) {
        // 开头字 [cellTitle rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound这个表示带有这个字得所有结果
        NSComparisonResult result = [obj compare:searchBar.text options:NSCaseInsensitiveSearch range:NSMakeRange(0, [searchBar.text length])];
        if ( result == NSOrderedSame || [obj rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound ) {
            
            [self.m_searchArray addObject:obj];
        }
        
    }
    
    // 遍历整个数组
    for (NSString * obj in self.m_MerchantArray) {
        
        NSComparisonResult result = [obj compare:searchBar.text options:NSCaseInsensitiveSearch range:NSMakeRange(0, [searchBar.text length])];
        if ( result == NSOrderedSame || [obj rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound ) {
            
            [self.m_searchArray addObject:obj];
        }
    }
    
    // 遍历整个数组
    for (NSString * obj in self.m_InviteArray) {
        
        NSComparisonResult result = [obj compare:searchBar.text options:NSCaseInsensitiveSearch range:NSMakeRange(0, [searchBar.text length])];
        if ( result == NSOrderedSame || [obj rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location != NSNotFound ) {
            
            [self.m_searchArray addObject:obj];
        }
    }
        
    [self.m_tableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [self hiddenNumPadDone:nil];
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
  
    self.m_searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    if ( searchBar.text.length != 0 ) {
        
        self.m_isSearching = YES;
        
    }else{
        
        self.m_isSearching = NO;
    }
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_searchBar.showsCancelButton = NO;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.m_searchBar resignFirstResponder];
    
    self.m_searchBar.showsCancelButton = NO;
    
}


@end
