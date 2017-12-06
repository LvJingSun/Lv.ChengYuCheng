//
//  GetOut_TranFrame.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  GetOut_TranModel;

@interface GetOut_TranFrame : NSObject

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGRect noticeF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) GetOut_TranModel *tranmodel;

@end
