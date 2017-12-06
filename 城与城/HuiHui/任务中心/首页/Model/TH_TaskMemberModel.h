//
//  TH_TaskMemberModel.h
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TH_TaskMemberModel : NSObject

//姓名
@property (nonatomic, copy) NSString *MemName;

//id
@property (nonatomic, copy) NSString *Memberid;

//佣金
@property (nonatomic, copy) NSString *TaskBonuses;

//完成状态
@property (nonatomic, copy) NSString *WhetherComplete;

//接受状态
@property (nonatomic, copy) NSString *WhetherToAccept;

//头像
@property (nonatomic, copy) NSString *MemPhoto;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)TH_TaskMemberModelWithDict:(NSDictionary *)dic;

@end
