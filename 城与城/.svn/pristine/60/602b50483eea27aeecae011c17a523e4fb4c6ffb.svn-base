//
//  AhDevDetailViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-1-27.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "AhDevDetailViewController.h"
#import "AhDevDetailTableViewCell.h"

@interface AhDevDetailViewController ()

{
    IBOutlet UITableView *DevTableview;
    
    NSMutableArray *recordsArray;
}

@end

@implementation AhDevDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    recordsArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self setTitle:@"预约详情"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

    [self Serverrecordlist];
}

-(void)leftClicked
{
    [self goBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 72;
            break;
        case 1:
            return 142;
            break;
        case 2:
            return 52;
            break;
        case 3:
            if (recordsArray.count!=0) {
                NSString *string = [NSString stringWithFormat:@"%@",[[recordsArray objectAtIndex:0] objectForKey:@"remark"]];
                CGSize  size= [string sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
                
                return size.height >105? 105:size.height;
            }
            break;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    switch (indexPath.row) {
        case 0:
            cell = [self tableView0:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableView1:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 2:
            cell = [self tableView2:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 3:
            cell = [self tableView3:tableView cellForRowAtIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    return cell;
    
}

- (UITableViewCell *)tableView0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    AhDevDetailTableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AhDevDetailTableViewCell" owner:self options:nil];
        
        cell = (AhDevDetailTableViewCell0 *)[nib objectAtIndex:0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (recordsArray.count == 0) {
        cell.DevDetailName.text = self.RealName;
    }else
    {
        NSDictionary *dic = [recordsArray objectAtIndex:0];
        cell.DevDetailName.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"toMemberName"]];
    }
    
    
    return cell;
}
- (UITableViewCell *)tableView1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    AhDevDetailTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AhDevDetailTableViewCell" owner:self options:nil];
        
        cell = (AhDevDetailTableViewCell1 *)[nib objectAtIndex:1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (recordsArray.count!=0) {
        NSDictionary *dic0 = [recordsArray objectAtIndex:0];
        NSDictionary *dic1 = [recordsArray objectAtIndex:1];
        cell.DevDetailPre_Name.text = [NSString stringWithFormat:@"%@",[dic0 objectForKey:@"commissionerName"]];
        cell.DevDetailsale_Name.text = [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"commissionerName"]];
        if ([[NSString stringWithFormat:@"%@",[dic0 objectForKey:@"type"]] isEqualToString:@"0"]) {
            cell.DevDetailPre.text = @"售前宣讲";
        }else if ([[NSString stringWithFormat:@"%@",[dic0 objectForKey:@"type"]] isEqualToString:@"1"])
        {
            cell.DevDetailPre.text = @"售前宣讲";
        }

        if ([[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"type"]] isEqualToString:@"0"]) {
            cell.DevDetailsale.text = @"售中咨询";
        }else if ([[NSString stringWithFormat:@"%@",[dic1 objectForKey:@"type"]] isEqualToString:@"1"])
        {
            cell.DevDetailsale.text = @"售中咨询";
        }
        
        NSString*Timestring0 =[NSString stringWithFormat:@"%@ %@",[dic0 objectForKey:@"startDate"],[dic0 objectForKey:@"endDate"]];
        NSArray *array0 = [Timestring0 componentsSeparatedByString:@" "];
        
        if ([[array0 objectAtIndex:0] isEqualToString:[array0 objectAtIndex:2]]) {
            cell.DevDetailPreTime.text = [NSString stringWithFormat:@"%@  %@至%@",[array0 objectAtIndex:0],[array0 objectAtIndex:1],[array0 objectAtIndex:3]];
        }else
        {
            cell.DevDetailPreTime.text = [NSString stringWithFormat:@"%@ 至 %@",[dic0 objectForKey:@"startDate"],[dic0 objectForKey:@"endDate"]];
        }
        
        
        NSString*Timestring1 =[NSString stringWithFormat:@"%@ %@",[dic1 objectForKey:@"startDate"],[dic1 objectForKey:@"endDate"]];
        NSArray *array1 = [Timestring1 componentsSeparatedByString:@" "];
        
        if ([[array1 objectAtIndex:0] isEqualToString:[array1 objectAtIndex:2]]) {
            cell.DevDetailsaleTime.text = [NSString stringWithFormat:@"%@  %@至%@",[array1 objectAtIndex:0],[array1 objectAtIndex:1],[array1 objectAtIndex:3]];
        }else
        {
            cell.DevDetailsaleTime.text = [NSString stringWithFormat:@"%@ 至 %@",[dic0 objectForKey:@"startDate"],[dic0 objectForKey:@"endDate"]];
        }
        
        
    }
    
    
    return cell;
}

- (UITableViewCell *)tableView2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    AhDevDetailTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AhDevDetailTableViewCell" owner:self options:nil];
        
        cell = (AhDevDetailTableViewCell2 *)[nib objectAtIndex:2];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (recordsArray.count!=0) {
        
        cell.DevDetailAddress.text = [NSString stringWithFormat:@"%@",[[recordsArray objectAtIndex:0] objectForKey:@"serviceAddress"] ];
        
    }
    
    
    return cell;
}

-(UITableViewCell *)tableView3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CtriphotelCellIdentifier";
    
    AhDevDetailTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AhDevDetailTableViewCell" owner:self options:nil];
        
        cell = (AhDevDetailTableViewCell3 *)[nib objectAtIndex:3];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    if (recordsArray.count!=0) {
        NSString *string = [NSString stringWithFormat:@"%@",[[recordsArray objectAtIndex:0] objectForKey:@"remark"]];
        CGSize  size= [string sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(300, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        cell.DevDetailnote.text = string;
        [cell.DevDetailnote setFrame:CGRectMake(cell.DevDetailnote.frame.origin.x, cell.DevDetailnote.frame.origin.y, cell.DevDetailnote.frame.size.width, size.height)];
    }
    return cell;
}

-(void)Serverrecordlist
{
    // 判断网络是否存在
    if ( ![self isConnectionAvailable] ) {
        return;
    }
    AppHttpClient* httpClient = [AppHttpClient sharedClient];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.recordId,     @"recordId",
                           nil];
    [httpClient request:@"KaiFaDetail.ashx" parameters:param success:^(NSJSONSerialization* json) {
        BOOL success = [[json valueForKey:@"status"] boolValue];
        [SVProgressHUD dismiss];
        if (success) {
            recordsArray = [json valueForKey:@"records"];
            [DevTableview reloadData];
        } else {
            NSString *msg = [json valueForKey:@"msg"];
            [SVProgressHUD showErrorWithStatus:msg];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}



@end
