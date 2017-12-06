//
//  GroupChatViewController.m
//  HuiHui
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "GroupChatViewController.h"

#import "CommonUtil.h"

#import "SVProgressHUD.h"

#import "AppHttpClient.h"

#import "groupChatCell.h"

#import "UIImageView+AFNetworking.h"

#import "JPinYinUtil.h"


@interface GroupChatViewController ()


@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UIView *m_titleView;

@property (weak, nonatomic) IBOutlet UILabel *m_tipLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *m_scrollerView;

@end

@implementation GroupChatViewController

@synthesize m_friendsList;

@synthesize m_allKeys;

@synthesize m_FriendsListDic;

@synthesize m_section;

@synthesize m_index;

@synthesize m_userId;

@synthesize m_userArray;

@synthesize m_selectedDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_friendsList = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_allKeys = [[NSArray alloc]init];
        
        m_FriendsListDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        m_section = 0;
        
        m_index = 0;
        
        friendHelp = [[FriendHelper alloc]init];
        
        m_userArray = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_selectedDic = [[NSMutableDictionary alloc]initWithCapacity:0];
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"发起群聊"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    if ( isIOS7 ) {
        self.m_tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    self.m_tipLabel.hidden = NO;
        
    self.m_friendsList = [friendHelp friendsList];

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

- (void)leftClicked{
    [self goBack];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.m_allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *str = [self.m_allKeys objectAtIndex:section];
    NSArray *friendsArr = [self.m_FriendsListDic objectForKey:str];
    return friendsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"groupChatCellIdentifier";
    groupChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"groupChatCell" owner:self options:nil];
        cell = (groupChatCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if ( self.m_allKeys.count != 0 ) {
        // 赋值
        NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
        NSArray *array = [self.m_FriendsListDic objectForKey:key];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        cell.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"RealName"]];
        [cell setImageViewWithPath:[NSString stringWithFormat:@"%@",[dic objectForKey:@"PhotoUrl"]]];
        cell.m_btn.userInteractionEnabled = NO;
        // MemberID 是NSNumber类型的，不是NSString类型的
        NSString *memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
        NSString *memIdString = [self.m_selectedDic objectForKey:memberId];
        if ( [memIdString isEqualToString:@"1"] ) {
            [cell.m_btn setImage:[UIImage imageNamed:@"group_chat_selected.png"] forState:UIControlStateNormal];

        }else{
            [cell.m_btn setImage:[UIImage imageNamed:@"group_chat_normal.png"] forState:UIControlStateNormal];
        }
    }
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 53.0f;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.m_allKeys;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* l_View = [[UIView alloc] init];
    l_View.backgroundColor = [UIColor colorWithRed:236.0/255 green:230.0/255 blue:240.0/255 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 22)];
    titleLabel.textColor=[UIColor grayColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    NSString *str = [self.m_allKeys objectAtIndex:section];
    titleLabel.text = str;
    [l_View addSubview:titleLabel];
    
    return l_View;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 赋值
    NSString *key = [self.m_allKeys objectAtIndex:indexPath.section];
    NSArray *array = [self.m_FriendsListDic objectForKey:key];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    NSString *memberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]];
    NSString *memIdKey = [self.m_selectedDic objectForKey:memberId];
    if ( [memIdKey isEqualToString:@"1"] ) {
        [self.m_selectedDic setValue:@"0" forKey:memberId];
        [self.m_userArray removeObject:dic];
    }else{
        [self.m_selectedDic setValue:@"1" forKey:memberId];
        [self.m_userArray addObject:dic];

    }
    // 刷新某一行
    NSArray *arr = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil];
    [self.m_tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    // 初始化上面的view，显示选择的用户所在的view
    [self initwithUserView];

  
}

- (void)initwithUserView{
    for (UIButton *btn in self.m_scrollerView.subviews) {
        [btn removeFromSuperview];
    }
    float sum = 0.0;
    if ( self.m_userArray.count != 0 ) {
        // 设置右上角的确定按钮
        [self setRightButtonWithTitle:@"确定" action:@selector(sureToGroupChat)];
        self.m_tipLabel.hidden = YES;
        for (int i = 0; i < self.m_userArray.count; i++) {
            NSDictionary *dic = [self.m_userArray objectAtIndex:i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(10 + 40 * i, 15, 30, 30);
            btn.backgroundColor = [UIColor redColor];
            
            NSString *userHeadImage = [dic objectForKey:@"PhotoUrl"];
            
            UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
            
            [imagV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:userHeadImage]]
                                          placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                                       
                                                       imagV.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                                       imagV.contentMode = UIViewContentModeScaleAspectFit;
                                                       
                                                       // btn赋值背景图片
                                                       [btn setImage:imagV.image forState:UIControlStateNormal];
                                                       
                                                   }
                                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                                       
                                                   }];
            [self.m_scrollerView addSubview:btn];
            sum = 40 * (i + 1);
            if ( sum >= 320.0) {
                [self.m_scrollerView setContentSize:CGSizeMake(sum + 40, 60)];
                [self.m_scrollerView setContentOffset:CGPointMake(40 * (i - 6), 0)];
            }else{
                [self.m_scrollerView setContentSize:CGSizeMake(0, 60)];
                [self.m_scrollerView setContentOffset:CGPointMake(0, 0)];
            }
        }

    }else{
        self.m_tipLabel.hidden = NO;
        self.navigationItem.rightBarButtonItem = nil;
    }
}


// 好友列表进行字母分类
- (void)sortFriends{
    // 先清空字典里的数据
    if ( self.m_selectedDic.count != 0 ) {
        [self.m_selectedDic removeAllObjects];
        
    }
    for (int i = 0; i< self.m_friendsList.count; i++) {
        NSDictionary *dic = [self.m_friendsList objectAtIndex:i];
        NSString *pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
        NSArray *array = [self sortBypinyin:pinyin];
        [self.m_FriendsListDic setObject:array forKey:pinyin];
        // 首次默认是否选择某个用户为0
        [self.m_selectedDic setValue:@"0" forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"MemberID"]]];
    }
    
    NSArray *allkeys  = [[self.m_FriendsListDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.m_allKeys = allkeys;
    self.m_tableView.hidden = NO;
    // 刷新列表
    [self.m_tableView reloadData];
    
}

- (NSString *)firstLetterForCompositeName:(NSString *)cityString {
    if (![cityString length]) {
        return @"";
    }
    unichar charString = [cityString characterAtIndex:0];
    NSArray *array = pinYinWithoutToneOnlyLetter(charString);
    if ([array count]) {
        return [[[array objectAtIndex:0] substringToIndex:1] uppercaseString];
    }
    return @"";
}

- (NSMutableArray *)sortBypinyin:(NSString *)pinyin{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i< self.m_friendsList.count; i++) {
        NSDictionary *dic = [self.m_friendsList objectAtIndex:i];
        NSString *data_pinyin = [self firstLetterForCompositeName:[dic objectForKey:@"RealName"]];
        if ([data_pinyin isEqualToString:pinyin]) {
            [array addObject:dic];
        }
    }
    return array;
}

-(void)sureToGroupChat
{
    
    
}



@end
