//
//  ToMeViewController.h
//  HuiHui
//
//  Created by mac on 2017/10/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "BaseViewController.h"

@interface ToMeViewController : BaseViewController

@property (nonatomic, copy) NSString *gameTypeID;

@property (nonatomic, copy) NSString *viewType; //1-给自己充值 2-给他人充值 3-赠送

@property (nonatomic, copy) NSString *rechargeType;

@end
