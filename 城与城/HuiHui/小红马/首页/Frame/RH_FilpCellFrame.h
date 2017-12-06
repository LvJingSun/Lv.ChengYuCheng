//
//  RH_FilpCellFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_FilpCellModel;

@interface RH_FilpCellFrame : NSObject

@property (nonatomic, assign) CGRect leftF;

@property (nonatomic, assign) CGRect rightF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect AD1F;

@property (nonatomic, assign) CGRect AD2F;

@property (nonatomic, assign) CGRect AD3F;

@property (nonatomic, assign) CGRect AD4F;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_FilpCellModel *cellModel;

@end
