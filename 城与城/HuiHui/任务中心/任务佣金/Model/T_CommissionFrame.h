//
//  T_CommissionFrame.h
//  HuiHui
//
//  Created by mac on 2017/3/28.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class T_NewTask;

@interface T_CommissionFrame : NSObject

@property (nonatomic, assign) CGRect borderF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect descF;

@property (nonatomic, assign) CGRect biaotiF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect countLineF;

@property (nonatomic, assign) CGRect starF;

@property (nonatomic, assign) CGRect starDescF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) T_NewTask *taskModel;

@end
