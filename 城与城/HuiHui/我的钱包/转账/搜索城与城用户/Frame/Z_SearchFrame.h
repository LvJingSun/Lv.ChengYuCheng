//
//  Z_SearchFrame.h
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Z_SearchModel;

@interface Z_SearchFrame : NSObject

@property (nonatomic, assign) CGRect phoneF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect nextF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Z_SearchModel *searchModel;

@end
