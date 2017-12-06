//
//  HH_MypartyViewController.m
//  HuiHui
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "HH_MypartyViewController.h"

#import "HH_partyViewController.h"

#import "HH_PartyDetailViewController.h"

#import "HH_partyListCell.h"

#import "EditingPartyViewController.h"

@interface HH_MypartyViewController ()

@property (weak, nonatomic) IBOutlet UIButton *m_OrganizeBtn;

@property (weak, nonatomic) IBOutlet UIButton *m_joinedBtn;

@property (weak, nonatomic) IBOutlet UILabel *m_emptyLabel;

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@property (weak, nonatomic) IBOutlet UIImageView *m_moveImgV;


// 按钮点击事件
- (IBAction)typeChange:(id)sender;

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight;

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint;


@end

@implementation HH_MypartyViewController

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
    [self setTitle:@"管理"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self setRightButtonWithTitle:@"发起活动" action:@selector(rightClicked)];
    
    self.m_tableView.hidden = NO;
    
    self.m_emptyLabel.hidden = YES;
    
    self.m_typeString = kOrganizeType;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar:YES];
    
    if ( self.m_typeString == kOrganizeType ) {
        
        // 默认选中待付款
        [self setLeft:YES withRight:NO];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
    }
    
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

// 滑块移动位置
- (void)moveImageMoveTo:(CGFloat)rectPoint
{
    [UIView beginAnimations:@"Flips1" context:(__bridge void *)(self)];
    [UIView setAnimationDuration:0.3];
    self.m_moveImgV.frame = CGRectMake(rectPoint, 40, 159, 4);
    [UIView commitAnimations];
}

- (void)leftClicked{
   
    // 切换到另一个控制器里面的翻转的动画效果
    CATransition *myTransition = [CATransition animation];
    myTransition.duration = 0.5f;
    myTransition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    myTransition.type = @"oglFlip";
    myTransition.subtype = kCATransitionFromLeft;
    [self.navigationController.view.layer addAnimation:myTransition forKey:@"oglFlip"];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (IBAction)typeChange:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( btn.tag == 100 ) {
        
        [self setLeft:YES withRight:NO];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:0];
        
    }else{
        
        [self setLeft:NO withRight:YES];
        
        // 设置滑块滚动的坐标
        [self moveImageMoveTo:161];
        
    }
}

- (void)setLeft:(BOOL)isLeft withRight:(BOOL)isRight{
    
    self.m_OrganizeBtn.selected = isLeft;
    
    self.m_joinedBtn.selected = isRight;
    
    if ( isLeft ) {
        
        self.m_OrganizeBtn.userInteractionEnabled = NO;
        self.m_joinedBtn.userInteractionEnabled = YES;
        
        self.m_typeString = kOrganizeType;
        
    }else{
        
        self.m_OrganizeBtn.userInteractionEnabled = YES;
        self.m_joinedBtn.userInteractionEnabled = NO;
        
        self.m_typeString = kJoinedType;
    }
    
    
    [self.m_tableView reloadData];
    
    // 请求数据
    
}

- (void)rightClicked{
    
    // 发起活动
    HH_partyViewController *VC = [[HH_partyViewController alloc]initWithNibName:@"HH_partyViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"HH_MyPartyCellIdentifier";
    
    HH_MyPartyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"HH_partyListCell" owner:self options:nil];
        
        cell = (HH_MyPartyCell *)[nib objectAtIndex:1];
        
    }
    
    
    if ( self.m_typeString == kOrganizeType ) {
        
        // 我发布的活动
       
        cell.m_nameLabel.text = @"sss";
        
        cell.m_statusLabel.text = @"已关闭";
        
        cell.m_subLabel.text = @"10月21日赞了该活动";
        
    }else{
        
        // 我参与的活动
        cell.m_nameLabel.text = @"cccccc";
        
        cell.m_statusLabel.text = @"10人已报名";
        
        cell.m_subLabel.text = @"10月22日赞了该活动";
        
    }
    
   
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // 根据类型判断进行跳转到不同的类
    if ( self.m_typeString == kOrganizeType ) {
    
        // 我发布的跳转到活动编辑的页面
        EditingPartyViewController *VC = [[EditingPartyViewController alloc]initWithNibName:@"EditingPartyViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
    
    }else{
    
        // 我参与的跳转到活动详情的页面
        HH_PartyDetailViewController *VC = [[HH_PartyDetailViewController alloc]initWithNibName:@"HH_PartyDetailViewController" bundle:nil];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
}

@end
