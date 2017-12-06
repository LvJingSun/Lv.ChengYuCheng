//
//  IntegrationViewController.h
//  baozhifu
//
//  Created by mac on 13-10-25.
//  Copyright (c) 2013年 mac. All rights reserved.
//  积分页面

#import "BaseViewController.h"
#import "PullTableView.h"

@interface IntegrationViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource, PullTableViewDelegate>{
   
    NSInteger pageIndex;
}

@property (strong, nonatomic) NSMutableArray *paymentItems;

@property (strong, nonatomic) NSString       *itemType;
// 积分
@property (nonatomic, strong) NSString       *m_BalanceString;
// 可兑换的积分
@property (nonatomic, strong) NSString       *m_ConvertibleString;


@end
