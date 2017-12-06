/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */
//easepushview hidetab

#import "ContactSelectionViewController.h"
#import "EMRemarkImageView.h"
#import "RealtimeSearchUtil.h"
#import "BaseTableViewCell.h"


@interface ContactSelectionViewController ()<UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSMutableArray *contactsSource;
@property (strong, nonatomic) NSMutableArray *selectedContacts;
@property (strong, nonatomic) NSMutableArray *blockSelectedUsernames;

@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic) UIScrollView *footerScrollView;
@property (strong, nonatomic) UIButton *doneButton;

@end

@implementation ContactSelectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _contactsSource = [NSMutableArray array];
        _selectedContacts = [NSMutableArray array];
        friendHelp = [[FriendHelper alloc]init];
        self.imageCache = [[ImageCache alloc]init];
        
//        [self setObjectComparisonStringBlock:^NSString *(id object) {
//            EMBuddy *buddy = (EMBuddy *)object;
//            return buddy.username;
//            
//            NSString * username ;
//            return username;
//        }];
//        
//        [self setComparisonObjectSelector:^NSComparisonResult(id object1, id object2) {
//            EMBuddy *buddy1 = (EMBuddy *)object1;
//            EMBuddy *buddy2 = (EMBuddy *)object2;
//            return [buddy1.username caseInsensitiveCompare: buddy2.username];
//            
//           NSString *buddy1 = (NSString *)object1;
//            NSString *buddy2 = (NSString *)object2;
//            return [buddy1 caseInsensitiveCompare: buddy2];

//        }];
    }
    return self;
}

- (instancetype)initWithBlockSelectedUsernames:(NSArray *)blockUsernames
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _blockSelectedUsernames = [NSMutableArray array];
        [_blockSelectedUsernames addObjectsFromArray:blockUsernames];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"选择联系人"];
    if ( isIOS7 ) {
        // section索引的背景色-右边排序的ABCD所在的视图
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};

    self.navigationItem.rightBarButtonItem = nil;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.view addSubview:self.footerView];
    self.tableView.editing = YES;
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.footerView.frame.size.height);
//    
//    if ([_blockSelectedUsernames count] > 0) {
//        for (NSString *username in _blockSelectedUsernames) {
//            NSInteger section = [self sectionForString:username];
//            NSMutableArray *tmpArray = [_dataSource objectAtIndex:section];
//            if (tmpArray && [tmpArray count] > 0) {
//                for (int i = 0; i < [tmpArray count]; i++) {
//                    EMBuddy *buddy = [tmpArray objectAtIndex:i];
//                    if ([buddy.username isEqualToString:username]) {
//                        [self.selectedContacts addObject:buddy];
//                        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section] animated:NO scrollPosition:UITableViewScrollPositionNone];
//                        
//                        break;
//                    }
//                }
//            }
//        }
        for (NSString *username in _blockSelectedUsernames) {
            NSInteger section = [self sectionForString:username];
            NSMutableArray *tmpArray = [_dataSource objectAtIndex:section];
            if (tmpArray && [tmpArray count] > 0) {
                for (int i = 0; i < [tmpArray count]; i++) {
                    NSDictionary *buddy = [tmpArray objectAtIndex:i];
                    if ([[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID"]] isEqualToString:username]) {
                        [self.selectedContacts addObject:buddy];
                        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section] animated:NO scrollPosition:UITableViewScrollPositionNone];
                        
                        break;
                    }
                }
            }
        }
        
        if ([_selectedContacts count] > 0) {
            [self reloadFooterView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideTabBar:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter

- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
        _footerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        _footerView.backgroundColor = [UIColor colorWithRed:207 / 255.0 green:210 /255.0 blue:213 / 255.0 alpha:0.7];
        
        _footerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, _footerView.frame.size.width - 30 - 70, _footerView.frame.size.height - 5)];
        _footerScrollView.backgroundColor = [UIColor clearColor];
        [_footerView addSubview:_footerScrollView];
        
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(_footerView.frame.size.width - 80, 8, 70, _footerView.frame.size.height - 16)];
        [_doneButton setBackgroundColor:[UIColor colorWithRed:10 / 255.0 green:82 / 255.0 blue:104 / 255.0 alpha:1.0]];
        [_doneButton setTitle:@"接受" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_doneButton];
    }
    
    return _footerView;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactListCell";
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    NSDictionary *buddy = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead.png"];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 4.0;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[buddy objectForKey:@"RealName"]];
    
    //头像
    {
        NSString * imagePath = [NSString stringWithFormat:@"%@",[buddy objectForKey:@"PhotoUrl"]];
        UIImage *reSizeImage = [self.imageCache getImage:imagePath];
        if (reSizeImage != nil) {
            cell.imageView.image = reSizeImage;
            return cell;
        }
        [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imagePath]]
                                placeholderImage:[UIImage imageNamed:@"moren.png"]
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                             cell.imageView.image = image;
                                             cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
                                             [self.imageCache addImage:image andUrl:imagePath];
                                         }
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                             
                                             cell.imageView.image = [UIImage imageNamed:@"moren.png"];
                                             
                                         }];

        
    }

    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    if ([_blockSelectedUsernames count] > 0) {
        NSDictionary *buddy = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return ![self isBlockUsername:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID"]]];
    }
    
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (![self.selectedContacts containsObject:object])
    {
        [self.selectedContacts addObject:object];
        
        [self reloadFooterView];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *buddy = [[_dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if ([self.selectedContacts containsObject:buddy]) {
        [self.selectedContacts removeObject:buddy];
        
        [self reloadFooterView];
    }
}


#pragma mark - private

- (BOOL)isBlockUsername:(NSString *)username
{
    if (username && [username length] > 0) {
        if ([_blockSelectedUsernames count] > 0) {
            for (NSString *tmpName in _blockSelectedUsernames) {
                if ([username isEqualToString:tmpName]) {
                    return YES;
                }
            }
        }
    }
    
    return NO;
}

- (void)reloadFooterView
{
    [self.footerScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat imageSize = self.footerScrollView.frame.size.height;
    NSInteger count = [self.selectedContacts count];
    self.footerScrollView.contentSize = CGSizeMake(imageSize * count, imageSize);
    for (int i = 0; i < count; i++) {
        NSDictionary *buddy = [self.selectedContacts objectAtIndex:i];
        EMRemarkImageView *remarkView = [[EMRemarkImageView alloc] initWithFrame:CGRectMake(i * imageSize, 0, imageSize, imageSize)];
        UIImage *reSizeImage = [self.imageCache getImage:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"PhotoUrl"]]];
        if (reSizeImage != nil) {
            remarkView.image = reSizeImage;
        }else{
            remarkView.image = [UIImage imageNamed:@"chatListCellHead.png"];
        }
        remarkView.remark = [NSString stringWithFormat:@"%@",[buddy objectForKey:@"RealName"]];
        [self.footerScrollView addSubview:remarkView];
    }
    
    if ([self.selectedContacts count] == 0) {
        [_doneButton setTitle:@"确定" forState:UIControlStateNormal];
    }
    else{
        [_doneButton setTitle:[NSString stringWithFormat:@"确定(%lu)", (unsigned long)[self.selectedContacts count]] forState:UIControlStateNormal];
    }
}

#pragma mark - public

- (void)loadDataSource
{
//    [self showHudInView:self.view hint:@"加载联系人..."];
    _contactsSource = [friendHelp friendsList];
    _dataSource = [self sortDataArrayself:self.contactsSource];
    [self hideHud];
    [self.tableView reloadData];
}

- (void)doneAction:(id)sender
{
    NSLog(@"lvjing4");
    if (_delegate && [_delegate respondsToSelector:@selector(viewController:didFinishSelectedSources:)]) {
        if ([_blockSelectedUsernames count] == 0) {
            [_delegate viewController:self didFinishSelectedSources:self.selectedContacts];
            [self.navigationController popViewControllerAnimated:NO];
        }
        else{
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *buddy in self.selectedContacts) {
                if(![self isBlockUsername:[NSString stringWithFormat:@"%@",[buddy objectForKey:@"MemberID"]]])
                {
                    [resultArray addObject:buddy];
                }
            }
            [_delegate viewController:self didFinishSelectedSources:resultArray];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
}

- (void) hideTabBar:(BOOL) hidden{
//    if ( isIOS7 ) {
//        [self.tabBarController.tabBar setHidden:hidden];
//        for(UIView *view in self.tabBarController.view.subviews)
//        {
//            CGSize m_size = self.tabBarController.view.frame.size;
//            if([view isKindOfClass:[UITabBar class]])
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width,m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height-49, view.frame.size.width, view.frame.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height+ 49);
//                }
//            }
//            else
//            {
//                if (self.tabBarController.tabBar.hidden) {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                } else {
//                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height-98)];
//                    self.navigationController.view.frame = CGRectMake(0, 0, m_size.width, m_size.height + 49);
//                }
//            }
//        }
//        
//    }else{
//        
//        if ( [self.tabBarController.view.subviews count] < 2 )
//        {
//            return;
//        }
//        UIView *contentView;
//        
//        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ){
//            contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//        }
//        else{
//            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//        }
//        if ( hidden ){
//            contentView.frame = self.tabBarController.view.bounds;
//        }
//        else
//        {
//            contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x,
//                                           self.tabBarController.view.bounds.origin.y,
//                                           self.tabBarController.view.bounds.size.width,
//                                           self.tabBarController.view.bounds.size.height - self.tabBarController.tabBar.frame.size.height + 49);
//        }
//        self.tabBarController.tabBar.hidden = hidden;
//    }
}




@end
