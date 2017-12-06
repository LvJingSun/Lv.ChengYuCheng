//
//  MyKeyCell.h
//  baozhifu
//
//  Created by mac on 13-6-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyKeyCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *txt_key_merchant;

@property (weak, nonatomic) IBOutlet UILabel *txt_key_activity;

@property (weak, nonatomic) IBOutlet UILabel *txt_key_number;

- (void)setValue:(NSDictionary *)item;

@end
