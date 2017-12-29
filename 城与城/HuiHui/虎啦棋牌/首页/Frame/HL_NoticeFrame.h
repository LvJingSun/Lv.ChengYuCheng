//
//  HL_NoticeFrame.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HL_NoticeModel;

@interface HL_NoticeFrame : NSObject

@property (nonatomic, assign) CGRect upLineF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect notice1F;

@property (nonatomic, assign) CGRect notice2F;

@property (nonatomic, assign) CGRect imgF;

@property (nonatomic, assign) CGRect bottomLineF;

@property (nonatomic, assign) CGRect clickF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) HL_NoticeModel *noticeModel;

@end
