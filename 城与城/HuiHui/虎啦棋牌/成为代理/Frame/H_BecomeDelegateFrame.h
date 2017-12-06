//
//  H_BecomeDelegateFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class H_BecomeDelegateModel;

@interface H_BecomeDelegateFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect priceF;

@property (nonatomic, assign) CGRect OriginalF;

@property (nonatomic, assign) CGRect OriginalLineF;

@property (nonatomic, assign) CGRect lookF;

@property (nonatomic, assign) CGRect buyF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) H_BecomeDelegateModel *model;

@end
