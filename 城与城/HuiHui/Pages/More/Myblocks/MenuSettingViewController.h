//
//  MenuSettingViewController.h
//  HuiHui
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  设置菜单参数的页面

#import "BaseViewController.h"

@interface MenuSettingViewController : BaseViewController<UITextFieldDelegate>{
    
    BOOL  isManlijian;
    BOOL  isGonggao;

    BOOL  isWaimai;
    BOOL  IsZCMLZ;//满立赠
    BOOL  IsZCFirstBuy;//首购减
    
    NSInteger ModelType;


}

@end
