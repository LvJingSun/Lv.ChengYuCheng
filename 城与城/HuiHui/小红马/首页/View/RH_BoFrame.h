//
//  RH_BoFrame.h
//  HuiHui
//
//  Created by mac on 2017/8/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_BoModel;

@interface RH_BoFrame : NSObject

@property (nonatomic, assign) CGRect leftF;

@property (nonatomic, assign) CGRect rightF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_BoModel *bomodel;

@end
