//
//  T_NewTask.h
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface T_NewTask : NSObject

@property (nonatomic, copy) NSString *TaskID;

@property (nonatomic, copy) NSString *TaskName;

@property (nonatomic, copy) NSString *TaskDescription;

@property (nonatomic, copy) NSString *TaskLevel;

@property (nonatomic, assign) BOOL isChoose;

- (instancetype)initWithDict:(NSDictionary *)dic;

+ (instancetype)T_NewTaskWithDict:(NSDictionary *)dic;

@end
