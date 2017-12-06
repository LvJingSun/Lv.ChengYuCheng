//
//  Home_FenLeiFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Home_FenLeiModel;

@interface Home_FenLeiFrame : NSObject

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) Home_FenLeiModel *fenleiModel;

@end
