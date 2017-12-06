//
//  Gold_OutFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Gold_OutModel;

@interface Gold_OutFrame : NSObject

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect qualityF;

@property (nonatomic, assign) CGRect lookF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect moneyF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Gold_OutModel *outModel;

@end
