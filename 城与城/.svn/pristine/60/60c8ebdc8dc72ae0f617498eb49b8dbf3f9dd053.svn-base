//
//  ChoseShopCell.m
//  baozhifu
//
//  Created by 冯海强 on 14-1-12.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ChoseShopCell.h"

@implementation ChoseShopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    

    // Configure the view for the selected state
}


-(IBAction)chose:(id)sender
{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IDarray"] ==nil) {
        
        self.chosedic = [[NSMutableArray alloc]initWithCapacity:0];
        self.chosedicname = [[NSMutableArray alloc]initWithCapacity:0];
    }
    else
    {
        NSArray *arrID = [[NSUserDefaults standardUserDefaults] objectForKey:@"IDarray"];
        NSArray *arrName = [[NSUserDefaults standardUserDefaults] objectForKey:@"Namearray"];
        
        self.chosedic = [arrID mutableCopy];
        self.chosedicname =[arrName mutableCopy];
        
    }
    
    UIButton *btn = (UIButton *)sender;
    
    if (self.Choseshop.selected)
    {
        for (int i = 0; i<self.chosedic.count; i++)
        {
            if ([[self.chosedic objectAtIndex:i]isEqualToString:[NSString stringWithFormat:@"%d",btn.tag]])
            {
                [self.chosedic removeObjectAtIndex:i];
                [self.chosedicname removeObjectAtIndex:i];
            }
            NSArray *newArray1 = [NSArray arrayWithArray:self.chosedic];
            [[NSUserDefaults standardUserDefaults] setObject:newArray1 forKey:@"IDarray"];
            
            NSArray *newArray2 = [NSArray arrayWithArray:self.chosedicname];
            [[NSUserDefaults standardUserDefaults] setObject:newArray2 forKey:@"Namearray"];
        }
        
        self.Choseshop.selected=NO;
        [self.Choseshop setImage:[UIImage imageNamed:@"comm_check_box_def.png"] forState:UIControlStateSelected];
    }
    else
    {
        if (self.chosedic.count==0) {
            self.chosedic = [[NSMutableArray alloc]initWithCapacity:0];
        }
        
        [self.chosedic addObject:[NSString stringWithFormat:@"%d",btn.tag]];
        NSArray *newArray = [NSArray arrayWithArray:self.chosedic];
        [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"IDarray"];
        
        for (NSDictionary *data in self.choseallnameCe)
        {
            if ([[NSString stringWithFormat:@"%d",btn.tag] isEqualToString:[NSString stringWithFormat:@"%@",[data objectForKey:@"MerchantShopID"]]])
            {
                [self.chosedicname addObject:[NSString stringWithFormat:@"%@",[data objectForKey:@"ShopName"]]];
                NSArray *newArray = [NSArray arrayWithArray:self.chosedicname];
                [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"Namearray"];
            }
            
        }
        
        self.Choseshop.selected=YES;
        [self.Choseshop setImage:[UIImage imageNamed:@"comm_check_box_selected.png"] forState:UIControlStateSelected];
    }
    
    NSString *strID;
    if (self.chosedic.count>1)
    {
        strID=[self.chosedic objectAtIndex:0];
        
        for (int i=1; i<self.chosedic.count; i++)
        {
            strID =[NSString stringWithFormat:@"%@,%@",strID,[self.chosedic objectAtIndex:i]];
        }
    }
    else
    {
        if (self.chosedic.count==1) {
            strID=[NSString stringWithFormat:@"%@",[self.chosedic objectAtIndex:0]];
        }else
        {
            strID=@"";
        }
    }
    
    
    NSString *strName;
    
    if (self.chosedicname.count>1)
    {
        strName=[self.chosedicname objectAtIndex:0];
        for (int i=1; i<self.chosedicname.count; i++)
        {
            strName =[NSString stringWithFormat:@"%@,%@",strName,[self.chosedicname objectAtIndex:i]];
        }
    }
    else
    {
        
        if (self.chosedicname.count==1) {
            strName=[NSString stringWithFormat:@"%@",[self.chosedicname objectAtIndex:0]];
        }else
        {
            strName=@"";
        }
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",strID] forKey:@"choseshopID"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",strName] forKey:@"choseshopName"];
    
    
    [self.Chosedelegate CellChosesshopValue:[[NSUserDefaults standardUserDefaults]objectForKey:@"choseshopName"] code:[[NSUserDefaults standardUserDefaults]objectForKey:@"choseshopID"]];
    
    
}




@end
