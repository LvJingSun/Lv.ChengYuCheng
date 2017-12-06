//
//  GameScrollFrame.h
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameScrollModel;

@interface GameScrollFrame : NSObject

@property (nonatomic, assign) CGRect scrollF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GameScrollModel *scrollmodel;

@end
