//
//  PayMentCell.m
//  HuiHui
//
//  Created by mac on 13-11-27.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "PayMentCell.h"

#import "CommonUtil.h"

@implementation PayMentCell

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
    
    self.labelAmount.text = [NSString stringWithFormat:@"%.4f", [[item objectForKey:@"amount"] floatValue]];
    NSString *operation = [item objectForKey:@"tradingOperations"];
    if ([OPERATION_INCOME isEqualToString:operation]) {
        self.labelStatus.text = [NSString stringWithFormat:@"%@(%@)",[[CommonUtil operationsDict] objectForKey:operation],[item objectForKey:@"transactionType"]];
        
    } else if ([OPERATION_EXPENDITURE isEqualToString:operation]) {
        self.labelStatus.text = [NSString stringWithFormat:@"%@(%@)",[[CommonUtil operationsDict] objectForKey:operation],[item objectForKey:@"transactionType"]];
    }
    
    self.labelMerchants.text = [item objectForKey:@"transactionNumber"];
    self.labelDateTime.text = [item objectForKey:@"transactionDate"];
}

@end
