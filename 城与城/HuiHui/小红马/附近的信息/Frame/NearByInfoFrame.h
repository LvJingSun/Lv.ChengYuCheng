//
//  NearByInfoFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NearByInfoModel;

@interface NearByInfoFrame : NSObject

@property (nonatomic, strong) NearByInfoModel *infoModel;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect addressF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect daohangF;

@end
