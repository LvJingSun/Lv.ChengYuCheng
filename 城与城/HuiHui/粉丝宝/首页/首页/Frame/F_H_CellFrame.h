//
//  F_H_CellFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class F_H_CellModel;

@interface F_H_CellFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect descF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect getF;

@property (nonatomic, assign) CGRect BGF;

@property (nonatomic, assign) CGRect ImgF;

@property (nonatomic, assign) CGRect ztDescF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) F_H_CellModel *cellModel;

@end
