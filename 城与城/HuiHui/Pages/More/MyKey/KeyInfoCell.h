//
//  KeyInfoCell.h
//  baozhifu
//
//  Created by mac on 13-6-19.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyKeyDetailViewController.h"

@interface KeyInfoCell : UITableViewCell {
    BOOL keySelected;
    NSInteger status;
}

@property (weak, nonatomic) IBOutlet UILabel *txt_title;

@property (weak, nonatomic) IBOutlet UILabel *txt_status;

@property (weak, nonatomic) IBOutlet UIButton *btnSelect;

@property (weak, nonatomic) IBOutlet UIButton *btnUse;

@property (weak, nonatomic) IBOutlet UIButton *btnRefund;

@property (weak, nonatomic) MyKeyDetailViewController *rootViewController;

// 用于存放点击的是哪个btn
@property (strong, nonatomic) NSMutableDictionary  *m_dic;


- (void)setValue:(NSDictionary *)key withItems:(NSDictionary *)items;

- (IBAction)btnUse:(id)sender;

- (IBAction)btnSelect:(id)sender;


@end
