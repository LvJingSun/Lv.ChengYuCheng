//
//  NEW_HL_CountFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class New_HL_CountModel;

@interface NEW_HL_CountFrame : NSObject

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) New_HL_CountModel *model;

@end
