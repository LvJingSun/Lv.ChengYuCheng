//
//  RepairMaintainFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RepairMaintainModel;

@interface RepairMaintainFrame : NSObject

@property (nonatomic, assign) CGRect imgF;

@property (nonatomic, assign) CGRect CountTitleF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect StatusTitleF;

@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect ContentTitleF;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect bgviewF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RepairMaintainModel *repairModel;

@end
