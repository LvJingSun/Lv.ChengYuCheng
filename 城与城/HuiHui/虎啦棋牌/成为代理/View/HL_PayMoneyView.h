//
//  HL_PayMoneyView.h
//  HuiHui
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HL_PayMoneyView : UIView

@property (nonatomic, weak) UILabel *moneyLab;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
