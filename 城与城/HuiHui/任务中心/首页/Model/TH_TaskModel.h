//
//  TH_TaskModel.h
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TH_TaskModel : NSObject

@property (nonatomic, copy) NSString *IsFriendsTaskOrMyTask;

@property (nonatomic, copy) NSString *PsID;

@property (nonatomic, copy) NSString *TaskName;

@property (nonatomic, copy) NSString *RName;

@property (nonatomic, copy) NSString *WhetherComplete;

@property (nonatomic, copy) NSString *WTime;

@property (nonatomic, copy) NSString *TaskBonuses;

@property (nonatomic, copy) NSString *ReTaskID;

@property (nonatomic, copy) NSString *ReMemName;

@property (nonatomic, copy) NSString *ReTime;

@property (nonatomic, copy) NSString *ReTaskAmount;

@property (nonatomic, copy) NSString *ReTaskBonuses;

@property (nonatomic, copy) NSString *StatusIs;

@property (nonatomic, copy) NSString *ReleaseName;

@property (nonatomic, copy) NSString *TaskType;

@property (nonatomic, copy) NSString *CompletedNum;

@property (nonatomic, copy) NSString *NeedNum;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)TH_TaskModelWithDict:(NSDictionary *)dic;

@end
