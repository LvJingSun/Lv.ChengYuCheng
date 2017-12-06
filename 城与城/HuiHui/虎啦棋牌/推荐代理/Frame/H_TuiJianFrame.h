//
//  H_TuiJianFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class H_TuiJianModel;

@interface H_TuiJianFrame : NSObject

@property (nonatomic, assign) CGRect imgF;

@property (nonatomic, assign) CGRect shareF;

@property (nonatomic, assign) CGRect copyF;

@property (nonatomic, assign) CGRect emailF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) H_TuiJianModel *model;

@end
