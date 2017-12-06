//
//  Life_CellFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Life_CellModel;

@interface Life_CellFrame : NSObject

@property (nonatomic, assign) CGRect image1F;

@property (nonatomic, assign) CGRect title1F;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect titleBGF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Life_CellModel *cellModel;

@end
