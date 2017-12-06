//
//  SearchRecordsHelper.h
//  HuiHui
//
//  Created by mac on 14-11-11.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchRecordsHelper : NSObject

// 刷新搜索记录
- (void)upDateSearch:(NSArray *)upDateSearch;
// 读取搜索记录的数组
- (NSMutableArray *)searchRecordList;

// 删除数据库中的数据
- (BOOL)deleteSearchList;

// 分类里显示的数据进行保存数据
- (void)updatecategoryList:(NSArray *)contactList;
- (NSMutableArray *)categoryList;
// 分类里显示的数据进行保存数据-未选择的分类进行保存
- (void)updateUncategoryList:(NSArray *)contactList;
- (NSMutableArray *)UncategoryList;
@end
