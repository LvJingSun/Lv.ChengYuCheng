//
//  FSB_CumulativeProfitViewController.h
//  HuiHui
//
//  Created by mac on 2017/5/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_BasicViewController.h"

@interface FSB_CumulativeProfitViewController : FSB_BasicViewController

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *merchantID;

@property (nonatomic, copy) NSString *redType;//1-平台红包 2-商户红包

@end
