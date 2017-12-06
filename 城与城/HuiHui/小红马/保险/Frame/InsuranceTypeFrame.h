//
//  InsuranceTypeFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class InsuranceTypeModel;

@interface InsuranceTypeFrame : NSObject

@property (nonatomic, assign) CGRect nameF;

@property (nonatomic, assign) CGRect iconF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) InsuranceTypeModel *typemodel;

@end
