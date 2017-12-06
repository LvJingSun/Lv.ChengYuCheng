//
//  AHchoseadressViewController.m
//  HuiHui
//
//  Created by 冯海强 on 15-2-6.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//

#import "AHchoseadressViewController.h"

@interface AHchoseadressViewController ()
{
    IBOutlet UITableView *AHtableview;
    
}

@end

@implementation AHchoseadressViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setTitle:@"选择"];
    [self setLeftButtonWithNormalImage:@"arrow_WL.png" action:@selector(leftClicked)];

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
    if ([self.AHType isEqualToString:@"province"]) {
        
        return self.AHarray.count;
    }else if ([self.AHType isEqualToString:@"city"]){
       
        return [[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] count];
    }else if ([self.AHType isEqualToString:@"county"]){
        
        return [[[[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:[self.AHcityrow intValue]] objectForKey:@"countyList"] count];
    }else if ([self.AHType isEqualToString:@"address"]){
       
        return [[[[[[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:[self.AHcityrow intValue]] objectForKey:@"countyList"] objectAtIndex:[self.AHcountyrow intValue]] objectForKey:@"addressList"] count];
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 45;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if ( cell == nil ) {
        
        cell = [(UITableViewCell *)[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    if ([self.AHType isEqualToString:@"province"]) {
        NSDictionary *dic = [self.AHarray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"provinceName"]];
    }else if ([self.AHType isEqualToString:@"city"]){
        NSDictionary *dic = [[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cityName"]];
    }else if ([self.AHType isEqualToString:@"county"]){
        NSDictionary *dic = [[[[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:[self.AHcityrow intValue]] objectForKey:@"countyList"] objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"countyName"]];
    }else if ([self.AHType isEqualToString:@"address"]){
        NSDictionary *dic = [[[[[[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:[self.AHcityrow intValue]] objectForKey:@"countyList"] objectAtIndex:[self.AHcountyrow intValue]] objectForKey:@"addressList"] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]];
    }
        
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.AHType isEqualToString:@"province"]) {
        NSMutableDictionary *dic = [self.AHarray objectAtIndex:indexPath.row];
        [self.delegate getAHCityName:dic andType:@"province" androw:indexPath];

    }else if ([self.AHType isEqualToString:@"city"]){
        NSMutableDictionary *dic = [[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:indexPath.row];
        [self.delegate getAHCityName:dic andType:@"city" androw:indexPath];

    }else if ([self.AHType isEqualToString:@"county"]){
        NSMutableDictionary *dic = [[[[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:[self.AHcityrow intValue]] objectForKey:@"countyList"] objectAtIndex:indexPath.row];
        [self.delegate getAHCityName:dic andType:@"county" androw:indexPath];

    }else if ([self.AHType isEqualToString:@"address"]){
        NSMutableDictionary *dic = [[[[[[[self.AHarray objectAtIndex:[self.AHprovincerow intValue]] objectForKey:@"cityList"] objectAtIndex:[self.AHcityrow intValue]] objectForKey:@"countyList"] objectAtIndex:[self.AHcountyrow intValue]] objectForKey:@"addressList"] objectAtIndex:indexPath.row];
        [self.delegate getAHCityName:dic andType:@"address" androw:indexPath];

    }
 
    [self.navigationController popViewControllerAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
