//
//  MyKeyDetailViewController.h
//  baozhifu
//
//  Created by mac on 13-6-16.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MyKeyDetailViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource> {
    BOOL isChecked;
    NSMutableArray *keys;
    NSArray *keyDictList;
    UINib *nib;
}

@property (strong, nonatomic) NSDictionary         *item;

@property (strong, nonatomic) NSMutableDictionary  *mDic;

@property (nonatomic, assign) NSInteger  m_SelectIndex;


- (void)useKey:(NSString *)key;

- (void)selectKey:(NSString *)key andAdd:(BOOL)needAdd withDic:(NSMutableDictionary *)dic;

// 申请退款的请求
- (void)RefundRequestSubmit:(NSString *)keyId;

@end
