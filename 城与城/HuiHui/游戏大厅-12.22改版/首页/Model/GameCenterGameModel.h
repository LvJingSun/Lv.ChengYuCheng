//
//  GameCenterGameModel.h
//  HuiHui
//
//  Created by mac on 2017/12/22.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameCenterGameModel : NSObject

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *gameName;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *gameType;//1-H5游戏 2-有详情的游戏

@property (nonatomic, copy) NSString *gameTypeName;

@property (nonatomic, copy) NSString *gameLink;

@end
