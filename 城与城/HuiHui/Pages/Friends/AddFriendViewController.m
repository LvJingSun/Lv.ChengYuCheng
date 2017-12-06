//
//  AddFriendViewController.m
//  HuiHui
//
//  Created by mac on 13-12-2.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "AddFriendViewController.h"

#import "SearchNumberViewController.h"

#import "PhoneContactsViewController.h"

@interface AddFriendViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


@end

@implementation AddFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"添加好友"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
   
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

#pragma - mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
        line.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
        
        [cell addSubview:line];
    }
    
    if ( indexPath.row == 0 ) {
        
        cell.textLabel.text = @"搜号码";
        
    }else{
        
         cell.textLabel.text = @"添加手机联系人";
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( indexPath.row == 0 ) {
        // 进入按号码搜索的界面
        SearchNumberViewController *VC = [[SearchNumberViewController alloc]initWithNibName:@"SearchNumberViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else{
        // 进入手机联系人的界面
        PhoneContactsViewController *VC = [[PhoneContactsViewController alloc]initWithNibName:@"PhoneContactsViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
   
}

@end
