//
//  ZhiPaiShopViewController.h
//  HuiHui
//
//  Created by mac on 15-8-21.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  指派店铺的页面

#import "BaseViewController.h"

@interface ZhiPaiShopViewController : BaseViewController{
    
    NSInteger  m_selectedIndex;
    
    
}


@property (nonatomic, strong) NSMutableArray  *m_shopList;

@property (nonatomic, strong) NSString        *m_orderId;

@end
