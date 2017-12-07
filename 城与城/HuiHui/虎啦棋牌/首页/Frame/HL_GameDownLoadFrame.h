//
//  HL_GameDownLoadFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_GameDownLoadModel;

@interface HL_GameDownLoadFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect downF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_GameDownLoadModel *gameModel;

@end
