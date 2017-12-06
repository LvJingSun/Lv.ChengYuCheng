//
//  GameBtnCellFrame.h
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameBtnCellModel;

@interface GameBtnCellFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect game1F;

@property (nonatomic, assign) CGRect game2F;

@property (nonatomic, assign) CGRect game3F;

@property (nonatomic, assign) CGRect game4F;

@property (nonatomic, assign) CGRect game5F;

@property (nonatomic, assign) CGRect game6F;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GameBtnCellModel *gameBtnCellModel;

@end
