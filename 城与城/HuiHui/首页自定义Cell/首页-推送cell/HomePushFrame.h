//
//  HomePushFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomePushModel;

@interface HomePushFrame : NSObject

@property (nonatomic, assign) CGRect lineviewF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGRect resultF;

@property (nonatomic, assign) CGRect descF;

@property (nonatomic, assign) CGRect contentImgF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect moreBtnF;

@property (nonatomic, assign) CGRect btnF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HomePushModel *pushmodel;

@end
