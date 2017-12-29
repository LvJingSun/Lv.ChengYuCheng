//
//  HL_RecommendFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_RecommendModel;

@interface HL_RecommendFrame : NSObject

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect line1F;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect line2F;

@property (nonatomic, assign) CGRect QQF;

@property (nonatomic, assign) CGRect QZoneF;

@property (nonatomic, assign) CGRect WXF;

@property (nonatomic, assign) CGRect CircleF;

@property (nonatomic, assign) CGRect MessageF;

@property (nonatomic, assign) CGRect CopyF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_RecommendModel *model;

@end
