//
//  Buy_DelegateViewController.h
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_BasicViewController.h"

@interface Buy_DelegateViewController : FSB_BasicViewController

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *type; //1-购买 2-续费 3-升级

@property (nonatomic, copy) NSString *difference; //差价

@end
