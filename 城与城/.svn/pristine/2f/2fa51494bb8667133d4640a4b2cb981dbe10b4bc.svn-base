//
//  ChooseAddressViewController.h
//  HuiHui
//
//  Created by mac on 15-8-14.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  选择收货地址的页面

#import "BaseViewController.h"

@protocol ChooseAddressDelegate <NSObject>

- (void)getAddressDetail:(NSMutableDictionary *)aDic;

@end

@interface ChooseAddressViewController : BaseViewController

// 存放地址的数据列表
@property (nonatomic, strong) NSMutableArray            *m_addressList;

// 存放勾选了哪个地址的字典
@property (nonatomic, strong) NSMutableDictionary       *m_dic;

@property (nonatomic, strong) NSString                  *m_addressId;

@property (nonatomic, assign) id<ChooseAddressDelegate>delegate;

@end
