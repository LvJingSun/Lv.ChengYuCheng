//
//  Ctrip_hotelInfomationViewController.m
//  HuiHui
//
//  Created by 冯海强 on 14-12-30.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "Ctrip_hotelInfomationViewController.h"
#import "Ctrip_hotelInfomationTableViewCell.h"
@interface Ctrip_hotelInfomationViewController ()

@end

@implementation Ctrip_hotelInfomationViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ServiceDesList = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"酒店信息";
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];
    
}

- (void)leftClicked{
    [self goBack];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    switch (section) {
        case 0:
            if (self.ServiceDesList.count ==0) {
                return 0;
            }
           return ((self.ServiceDesList.count-1)/3)+1;
            break;
            case 1:
            return 1;
        default:
            break;
    }

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
            cell = [self tableViewinfo0:tableView cellForRowAtIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableViewinfo1:tableView cellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

// 第0行显示的数据
- (UITableViewCell *)tableViewinfo0:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    Ctrip_hotelInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelInfomationTableViewCell" owner:self options:nil];
        cell = (Ctrip_hotelInfomationTableViewCell *)[nib objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
    
    int count = indexPath.row *3 +3;
    if (count >self.ServiceDesList.count) {
        count = self.ServiceDesList.count;
    }
    for (int iii =indexPath.row *3; iii<count; iii++) {
        NSDictionary * dic = [self.ServiceDesList objectAtIndex:iii];
        switch (iii%3) {
            case 0:
                cell.DescriptiveText1.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"DescriptiveText"]];
                break;
            case 1:
                cell.DescriptiveText2.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"DescriptiveText"]];
                break;
            case 2:
                cell.DescriptiveText3.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"DescriptiveText"]];
                break;
                
            default:
                break;
        }
    }
    }
    
    return cell;
}
// 第1行显示的数据
- (UITableViewCell *)tableViewinfo1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"IntroductionCellIndentifier";
    Ctrip_hotelInfomationTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if ( cell == nil ) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Ctrip_hotelInfomationTableViewCell" owner:self options:nil];
        cell = (Ctrip_hotelInfomationTableViewCell1 *)[nib objectAtIndex:1];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.DescriptionText.text = [NSString stringWithFormat:@"\t%@",self.Description];
        CGSize size = [self.Description sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(305, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        cell.DescriptionText.frame = CGRectMake(8, 12, 305, size.height);
        
    }
    
    return cell;
}



#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 35;
    }else
    {
        CGSize size = [self.Description sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(305, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height+40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];
    switch (section) {
        case 0:
            [label setText:@"酒店设施"];
            break;
        case 1:
            [label setText:@"酒店介绍"];
            break;
        default:
            break;
    }
    [contentView addSubview:label];
    return contentView;
}





@end
