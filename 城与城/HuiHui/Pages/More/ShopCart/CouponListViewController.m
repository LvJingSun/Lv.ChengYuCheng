//
//  CouponListViewController.m
//  HuiHui
//
//  Created by mac on 13-12-5.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CouponListViewController.h"

#import "CouponCell.h"

@interface CouponListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;


@end

@implementation CouponListViewController

@synthesize m_couponArray;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_couponArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"优惠券"];
    
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    // 假数据填充
    self.m_couponArray = [NSMutableArray arrayWithObjects:@"10元",@"5元",@"1元", nil];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_couponArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CouponCellIdentifier";
    
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CouponCell" owner:self options:nil];
        
        cell = (CouponCell *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    
    // 赋值
    cell.m_priceLabel.text = [NSString stringWithFormat:@"%@",[self.m_couponArray objectAtIndex:indexPath.row]];
    
    cell.m_resourceLabel.text = [NSString stringWithFormat:@"来自:城与城"];
    
    cell.m_timeLabel.text = [NSString stringWithFormat:@"有效期:2013.11.11-2013.12.30"];
    
    return cell;
    
}

#pragma mark - UITableVIewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( delegate && [delegate respondsToSelector:@selector(getCounponString:)] ) {
        
        [delegate performSelector:@selector(getCounponString:) withObject:[self.m_couponArray objectAtIndex:indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
