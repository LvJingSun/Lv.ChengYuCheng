//
//  BankCardListViewController.h
//  baozhifu
//
//  Created by mac on 13-7-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//  我的银行卡列表

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BankCardListViewController : BaseViewController<UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *bankItems;

@property (nonatomic, strong) NSString *m_defaultCardId;

@property (assign, nonatomic) NSInteger m_index;

- (void)loadData;

- (void)selectCard:(NSString *)memberBankCardId index:(NSInteger)index status:(NSString *)status;

- (void)deleteCard:(NSString *)memberBankCardId index:(NSInteger)index;

- (void)verifyCard:(NSDictionary *)bankInfo;

// 设置为默认的请求数据
- (void)defaultSubmit;


@end
