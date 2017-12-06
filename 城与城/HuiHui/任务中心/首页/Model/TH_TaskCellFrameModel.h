//
//  TH_TaskCellFrameModel.h
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TH_TaskModel;

@interface TH_TaskCellFrameModel : NSObject

//任务名字frame
@property (nonatomic, assign) CGRect TaskNameF;

//任务类型frame
@property (nonatomic, assign) CGRect TaskTypeF;

//添加按钮frame
@property (nonatomic, assign) CGRect AddF;

//分割线frame
@property (nonatomic, assign) CGRect LineF;

//底部线条frame
@property (nonatomic, assign) CGRect bottomF;

//发布人frame
@property (nonatomic, assign) CGRect PersonF;

//任务完成情况frame
@property (nonatomic, assign) CGRect CompleteF;

//任务佣金frame
@property (nonatomic, assign) CGRect CountF;

//任务时间frame
@property (nonatomic, assign) CGRect TimeF;

//任务状态标题frame
@property (nonatomic, assign) CGRect StatusTitleF;

//任务状态frame
@property (nonatomic, assign) CGRect StatusF;

//任务模型
@property (nonatomic, strong) TH_TaskModel *taskmodel;

//cell的高度
@property (nonatomic, assign) CGFloat height;

@end
