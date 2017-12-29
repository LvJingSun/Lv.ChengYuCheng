//
//  GameCenterGameArrayFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameCenterGameArrayModel;

@interface GameCenterGameArrayFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect game1F;

@property (nonatomic, assign) CGRect game2F;

@property (nonatomic, assign) CGRect game3F;

@property (nonatomic, assign) CGRect game4F;

@property (nonatomic, assign) CGRect game5F;

@property (nonatomic, assign) CGRect game6F;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GameCenterGameArrayModel *arrayModel;

@end
