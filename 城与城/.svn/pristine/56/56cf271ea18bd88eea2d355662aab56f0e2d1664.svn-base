//
//  HH_PartyListViewController.m
//  HuiHui
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_PartyListViewController.h"

#import "HH_MypartyViewController.h"

#import "HH_partyListCell.h"

#import "HH_PartyDetailViewController.h"


@interface HH_PartyListViewController ()

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


@end

@implementation HH_PartyListViewController

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
    [self setTitle:@"活动列表"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"管理" action:@selector(rightClicked)];
    
    self.m_emptyLabel.hidden = YES;
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 删除window上面的图片
//    for (id view in Appdelegate.window.subviews) {
//        if ( [view isKindOfClass:[UIImageView class]] ) {
//            UIImageView *imgV = (UIImageView *)view;
//            if ( imgV.tag == 111 ) {
//                [view removeFromSuperview];
//            }
//        }
//    }
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
//    [self hideTabBar:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
- (void)leftClicked{
    
    [self hideTabBar:NO];
    
    [self goBack];
}

- (void)rightClicked{
    
//    UIImageView *imagV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    imagV.image = [UIImage imageNamed:@"huihui.png"];
//    imagV.tag = 111;
//    [Appdelegate.window insertSubview:imagV atIndex:0];
    
    HH_MypartyViewController *VC = [[HH_MypartyViewController alloc]initWithNibName:@"HH_MypartyViewController" bundle:nil];
    
    // 切换到另一个控制器里面的翻转的动画效果
    CATransition *myTransition = [CATransition animation];
    myTransition.duration = 0.5f;
    myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    myTransition.type = @"oglFlip";
    myTransition.subtype = kCATransitionFromRight;
    [self.navigationController.view.layer addAnimation:myTransition forKey:@"oglFlip"];
    
    [self.navigationController pushViewController:VC animated:NO];

    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HH_partyListCellIdentifier";
    
    HH_partyListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_partyListCell" owner:self options:nil];
        
        cell = (HH_partyListCell *)[nib objectAtIndex:0];
        
    }
    
    // 赋值
    cell.m_nameLabel.text = @"sss";
    
    
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 进入活动详情
    HH_PartyDetailViewController *VC = [[HH_PartyDetailViewController alloc]initWithNibName:@"HH_PartyDetailViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

@end
