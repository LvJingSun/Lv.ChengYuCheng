//
//  R_PersonFrame.h
//  HuiHui
//
//  Created by mac on 2017/11/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class R_PersonModel;

@interface R_PersonFrame : NSObject

@property (nonatomic, assign) CGRect bgF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGRect markF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) R_PersonModel *personModel;

@end
