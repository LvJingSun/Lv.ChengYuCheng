//
//  MyservicersViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "MyservicersViewController.h"
#import "MyserviceTableViewCell.h"
#import "HistoryserviceViewController.h"

@interface MyservicersViewController ()
{
    IBOutlet UITableView *Service_tableview;
    
    NSMutableArray *Servicersarray;
}

@end

@implementation MyservicersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Servicersarray = [[NSMutableArray alloc]initWithCapacity:0];
    
    [self setTitle:@"我服务的代理商"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
    [self Servicers_loadData];

}

-(void)leftClicked
{
    [self goBack];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Servicersarray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    MyserviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyserviceTableViewCell" owner:self options:nil];
        
        cell = (MyserviceTableViewCell *)[nib objectAtIndex:0];
        
    }
    
    NSDictionary *dic = [Servicersarray objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"toMemberName"]];
    if ([[dic objectForKey:@"isService"] boolValue]) {
        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"serviceStar"]] isEqualToString:@"1"]) {
            cell.typeLabel.text = [NSString stringWithFormat:@"本周已服务\n打分:满意"];
        }else if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"serviceStar"]] isEqualToString:@"2"])
        {
            cell.typeLabel.text = [NSString stringWithFormat:@"本周已服务\n打分:不满意"];
        }

    }else
    {
        cell.typeLabel.text = [NSString stringWithFormat:@"本周待服务"];
        cell.typeLabel.textColor = RGBACOLOR(232, 133, 44, 1);
    }
    
    [cell SetServicePhoto:[NSString stringWithFormat:@"%@",[dic objectForKey:@"photoMidUrl"]]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [Servicersarray objectAtIndex:indexPath.row];

    HistoryserviceViewController *VC = [[HistoryserviceViewController alloc]initWithNibName:@"HistoryserviceViewController" bundle:nil];
    VC.toMemberId = [NSString stringWithFormat:@"%@",[dic objectForKey:@"tomemberId"]];
    
    [self.navigationController pushViewController:VC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


//我服务的代理商
- (void)Servicers_loadData {
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    NSString *memberId = [CommonUtil getValueByKey:MEMBER_ID];
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           memberId,     @"fromMemberId",
                           nil];
    if (Servicersarray.count ==0) {
        [SVProgressHUD showWithStatus:@"数据加载中"];
    }
    [httpClient request:@"MyServiceAgents.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        if (success) {
            [SVProgressHUD dismiss];
            Servicersarray = [json valueForKey:@"agents"];
            if (Servicersarray.count != 0) {
                
                [Service_tableview reloadData];
                
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"暂无代理商"];

            }
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}

@end
