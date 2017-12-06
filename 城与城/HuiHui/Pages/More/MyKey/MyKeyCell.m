//
//  MyKeyCell.m
//  baozhifu
//
//  Created by mac on 13-6-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "MyKeyCell.h"

#import "CommonUtil.h"

@interface MyKeyCell()


@end

@implementation MyKeyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setValue:(NSDictionary *)item {
    if (item == nil) {
        return;
    }
   
    
    NSString *keyType = [item objectForKey:@"keyType"];
    
    if ([KEY_TYPE_SERVICE isEqualToString:keyType]) {
        
        self.txt_key_merchant.textColor = [UIColor blackColor];
     
        self.txt_key_merchant.text = [item objectForKey:@"allName"];

        self.txt_key_activity.text = [item objectForKey:@"svcName"];
        
        self.txt_key_number.text = [NSString stringWithFormat:@"KEY数量：%@",[item objectForKey:@"keyNum"]];

    
    } else if ([KEY_TYPE_ACTIVITY isEqualToString:keyType]) {
        
        self.txt_key_merchant.textColor = [UIColor blackColor];

        self.txt_key_merchant.text = [item objectForKey:@"allName"];
      
        self.txt_key_activity.text = [item objectForKey:@"activityName"];
        
        
        self.txt_key_number.text = [NSString stringWithFormat:@"KEY数量：%@",[item objectForKey:@"keyNum"]];

   
    }else  if ([KEY_TYPE_BUY isEqualToString:keyType]){
       
        self.txt_key_merchant.textColor = [UIColor blackColor];

        self.txt_key_merchant.text = [item objectForKey:@"allName"];

        self.txt_key_activity.text = [item objectForKey:@"goodName"];
        
        
        self.txt_key_number.text = [NSString stringWithFormat:@"KEY数量：%@",[item objectForKey:@"keyNum"]];

    
    }else{
        
        self.txt_key_merchant.textColor = [UIColor redColor];

        self.txt_key_merchant.text = [item objectForKey:@"typeValue"];

        self.txt_key_activity.text = [item objectForKey:@"allName"];
        
        self.txt_key_number.text = [NSString stringWithFormat:@"KEY值：%@",[item objectForKey:@"eleCouponsValue"]];


        
    }
}

@end
