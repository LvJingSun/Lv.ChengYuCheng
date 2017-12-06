//
//  SponsorTypeViewController.m
//  HuiHui
//
//  Created by mac on 13-12-4.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "SponsorTypeViewController.h"

@interface SponsorTypeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *m_tableView;

@end

@implementation SponsorTypeViewController

@synthesize m_typeArray;

@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        m_typeArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setTitle:@"赞助类型"];
    
    [self setLeftButtonWithNormalImage:@"back.png" action:@selector(leftClicked)];
    
    self.m_typeArray = [NSMutableArray arrayWithObjects:@"休闲",@"娱乐",@"补贴",@"奖金", nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hideTabBar: YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
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
    
    return self.m_typeArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    // 赋值

    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.m_typeArray objectAtIndex:indexPath.row]];

    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];

    return cell;

}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( delegate && [delegate respondsToSelector:@selector(getTypeName:)] ) {
        
        [delegate performSelector:@selector(getTypeName:) withObject:[self.m_typeArray objectAtIndex:indexPath.row]];
    }
    
    // 返回上一级
    [self.navigationController popViewControllerAnimated:YES];
}

@end
