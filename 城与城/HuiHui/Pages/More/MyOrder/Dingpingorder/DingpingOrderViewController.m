//
//  DingpingOrderViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-9.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "DingpingOrderViewController.h"
#import "DingpingOrderTableViewCell.h"

@interface DingpingOrderViewController ()

@end

@implementation DingpingOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"大众点评订单"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

}

- (void)leftClicked{
    
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell  = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
    }else if(indexPath.section ==1)
    {
        cell  = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}
    
- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    DingpingOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DingpingOrderTableViewCell" owner:self options:nil];
        cell = (DingpingOrderTableViewCell *)[nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titlelabel.layer.masksToBounds = YES;//设置圈角
    cell.titlelabel.layer.cornerRadius = 5.0;
    cell.titlelabel.text = [NSString stringWithFormat:@"\t目前，大众点评网的所有订单暂不支持显示，若您需要退款、查询等操作，可以联系点评网官方客服。\n您需要提供：\n\t1、购买时的手机号\n\t2、购买的商品"];
    return cell;
}
- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    DingpingOrderTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"DingpingOrderTableViewCell" owner:self options:nil];
        cell = (DingpingOrderTableViewCell1 *)[nib objectAtIndex:1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.titleBtn addTarget:self action:@selector(ChosePhone) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section ==0) {
        return 148;
    }else if (indexPath.section ==1)
    {
        return 58;

    }
    return 0;
}

-(void)ChosePhone
{
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"400-820-5527",nil];
    sheet.tag = 10001;
    [sheet showInView:self.view];
    
}
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 10001)
    {
        if (buttonIndex==0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4008205527"]];
        }
        
    }
    
    
}

@end
