//
//  HL_MyInfoFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_MyInfoModel;

@interface HL_MyInfoFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_MyInfoModel *infoModel;

@end
