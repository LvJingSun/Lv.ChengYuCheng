//
//  RH_ChildCarFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_CarBrandModel;

@interface RH_ChildCarFrame : NSObject

//@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect titleF;

//@property (nonatomic, assign) CGRect buttonF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_CarBrandModel *brandmodel;

@end
