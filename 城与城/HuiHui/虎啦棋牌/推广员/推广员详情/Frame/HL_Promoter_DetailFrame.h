//
//  HL_Promoter_DetailFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_Promoter_DetailModel;

@interface HL_Promoter_DetailFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect content1F;

@property (nonatomic, assign) CGRect content2F;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect deleteF;

@property (nonatomic, assign) CGRect deleteBGF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_Promoter_DetailModel *model;

@end
