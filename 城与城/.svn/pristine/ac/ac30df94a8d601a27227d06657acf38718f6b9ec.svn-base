//
//  CouponListViewController.h
//  HuiHui
//
//  Created by mac on 13-12-5.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  优惠券列表

#import "BaseViewController.h"

@protocol CounponListDelegate <NSObject>

- (void)getCounponString:(NSString *)aCounpon;

@end

@interface CouponListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

// 存放优惠券数据的数组
@property (nonatomic, strong) NSMutableArray            *m_couponArray;
// 设置代理，触发选择优惠券的时候执行代理方法
@property (nonatomic, assign) id    <CounponListDelegate>delegate;

@end
