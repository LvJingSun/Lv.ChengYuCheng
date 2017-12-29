//
//  H_MyMoneyFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class H_MyMoneyModel;

@interface H_MyMoneyFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect IDF;

@property (nonatomic, assign) CGRect countF;

//@property (nonatomic, assign) CGRect statusF;

@property (nonatomic, assign) CGRect sourceF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) H_MyMoneyModel *model;

@end
