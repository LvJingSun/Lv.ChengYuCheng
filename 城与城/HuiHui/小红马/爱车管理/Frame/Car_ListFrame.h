//
//  Car_ListFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_CarModel;

@interface Car_ListFrame : NSObject

@property (nonatomic, assign) CGRect imgF;

@property (nonatomic, assign) CGRect defaultImgF;

@property (nonatomic, assign) CGRect defaultTitleF;

@property (nonatomic, assign) CGRect carModelF;

@property (nonatomic, assign) CGRect carPlateF;

@property (nonatomic, assign) CGRect carStatusF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect MoreF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_CarModel *carmodel;

@end
