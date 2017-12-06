//
//  ContactHelper.h
//  HuiHui
//
//  Created by mac on 14-7-16.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactHelper : NSObject

// 更新数据库中的数据
- (void)updateData:(NSArray *)list;
// 获取数据库中的数组
- (NSMutableArray *)contactList;

// 关注过此人后将状态改变
+ (BOOL)updateMessage:(NSString *)OtmemId;

@end
