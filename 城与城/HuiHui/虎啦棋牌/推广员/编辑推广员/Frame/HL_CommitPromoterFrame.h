//
//  HL_CommitPromoterFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_CommitPromoterModel;

@interface HL_CommitPromoterFrame : NSObject

@property (nonatomic, assign) CGRect phoneF;

//@property (nonatomic, assign) CGRect noticeF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect sureF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_CommitPromoterModel *model;

@end
