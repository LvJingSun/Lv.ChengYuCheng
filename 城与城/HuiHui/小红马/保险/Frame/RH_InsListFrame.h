//
//  RH_InsListFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RH_InsListModel;

@interface RH_InsListFrame : NSObject

@property (nonatomic, assign) CGRect COTitleF;

@property (nonatomic, assign) CGRect COF;

@property (nonatomic, assign) CGRect TimeTitleF;

@property (nonatomic, assign) CGRect TimeF;

@property (nonatomic, assign) CGRect CountTitleF;

@property (nonatomic, assign) CGRect CountF;

@property (nonatomic, assign) CGRect PlateTitleF;

@property (nonatomic, assign) CGRect PlateF;

@property (nonatomic, assign) CGRect DrivingYearTitleF;

@property (nonatomic, assign) CGRect DrivingYearF;

@property (nonatomic, assign) CGRect CarYearTitleF;

@property (nonatomic, assign) CGRect CarYearF;

@property (nonatomic, assign) CGRect StatusIconF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) RH_InsListModel *listModel;

@end
