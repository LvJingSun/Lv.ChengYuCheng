//
//  GroupSettingViewController.m
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-8-18.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//
//easepushview hidetab

#import "GroupSettingViewController.h"

@interface GroupSettingViewController ()
{
    EMGroup *_group;
    BOOL _isOwner;
    UISwitch *_pushSwitch;
    UISwitch *_blockSwitch;
}

@end

@implementation GroupSettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithGroup:(EMGroup *)group
{
    self = [self initWithStyle:UITableViewStylePlain];
    if (self) {
        _group = group;
        
        NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
        NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
        _isOwner = [_group.owner isEqualToString:loginUsername];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle: @"群设置"];
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    UITextAttributeTextColor: [UIColor whiteColor],
                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:20]};
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backButton setImage:[UIImage imageNamed:@"arrow_WL.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    if (!_isOwner) {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        [addButton setTitle:@"保存" forState:UIControlStateNormal];
        [addButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [addButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [addButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *_addFriendItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
        self.navigationItem.rightBarButtonItem = _addFriendItem;
    }
    
    _pushSwitch = [[UISwitch alloc] init];
    [_pushSwitch addTarget:self action:@selector(pushSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [_pushSwitch setOn:_group.isPushNotificationEnabled animated:YES];
    
    _blockSwitch = [[UISwitch alloc] init];
    [_blockSwitch addTarget:self action:@selector(blockSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    [_blockSwitch setOn:_group.isBlocked animated:YES];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self hideTabBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self hideTabBar:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_isOwner) {
        return 1;
    }
    else{
        if (_blockSwitch.isOn) {
            return 1;
        }
        else{
            return 2;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if ((_isOwner && indexPath.row == 0) || (!_isOwner && indexPath.row == 1)) {
        _pushSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_pushSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _pushSwitch.frame.size.height) / 2, _pushSwitch.frame.size.width, _pushSwitch.frame.size.height);
        
        if (_pushSwitch.isOn) {
            cell.textLabel.text = @"接收并提示群消息";
        }
        else{
            cell.textLabel.text = @"只接收不提示群消息";
        }
        
        [cell.contentView addSubview:_pushSwitch];
        [cell.contentView bringSubviewToFront:_pushSwitch];
    }
    else if(!_isOwner && indexPath.row == 0){
        _blockSwitch.frame = CGRectMake(self.tableView.frame.size.width - (_blockSwitch.frame.size.width + 10), (cell.contentView.frame.size.height - _blockSwitch.frame.size.height) / 2, _blockSwitch.frame.size.width, _blockSwitch.frame.size.height);
        
        cell.textLabel.text = @"屏蔽群消息";
        [cell.contentView addSubview:_blockSwitch];
        [cell.contentView bringSubviewToFront:_blockSwitch];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private

- (void)isIgnoreGroup:(BOOL)isIgnore
{
    __weak typeof(self) weakSelf = self;
    [self showHudInView:self.view hint:@"设置属性"];
    [[EaseMob sharedInstance].chatManager asyncIgnoreGroupPushNotification:_group.groupId isIgnore:isIgnore completion:^(NSArray *ignoreGroupsList, EMError *error) {
        [weakSelf hideHud];
        if (!error) {
            [weakSelf showHint:@"设置成功"];
        }
        else{
            [weakSelf showHint:@"设置失败"];
        }
    } onQueue:nil];
}

#pragma mark - action

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushSwitchChanged:(id)sender
{
    if (_isOwner) {
        BOOL toOn = _pushSwitch.isOn;
        [self isIgnoreGroup:!toOn];
    }
    [self.tableView reloadData];
}

- (void)blockSwitchChanged:(id)sender
{
    [self.tableView reloadData];
}

- (void)saveAction:(id)sender
{
    if (_blockSwitch.isOn != _group.isBlocked) {
        __weak typeof(self) weakSelf = self;
        [self showHudInView:self.view hint:@"设置属性"];
        if (_blockSwitch.isOn) {
            [[EaseMob sharedInstance].chatManager asyncBlockGroup:_group.groupId completion:^(EMGroup *group, EMError *error) {
                [weakSelf hideHud];
                [weakSelf showHint:@"设置成功"];
            } onQueue:nil];
        }
        else{
            [[EaseMob sharedInstance].chatManager asyncUnblockGroup:_group.groupId completion:^(EMGroup *group, EMError *error) {
                [weakSelf hideHud];
                [weakSelf showHint:@"设置成功"];
            } onQueue:nil];
        }
    }
    
    if (_pushSwitch.isOn != _group.isPushNotificationEnabled) {
        [self isIgnoreGroup:!_pushSwitch.isOn];
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
