//
//  FSB_GameCenterViewController.h
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSB_GameCenterViewController;

typedef void (^GoodsInfoNavBlock)(FSB_GameCenterViewController *, CGFloat);

@interface FSB_GameCenterViewController : UIViewController

@property (nonatomic, copy)GoodsInfoNavBlock goodsInfoNavBlock;

@end
