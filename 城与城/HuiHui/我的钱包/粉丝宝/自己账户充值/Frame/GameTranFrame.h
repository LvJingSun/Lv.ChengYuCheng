//
//  GameTranFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameTranModel;

@interface GameTranFrame : NSObject

@property (nonatomic, assign) CGRect typeF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect dateF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GameTranModel *tranModel;

@end
