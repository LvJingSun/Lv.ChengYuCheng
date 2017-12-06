//
//  ApplyInPutFrame.h
//  HuiHui
//
//  Created by mac on 2017/6/10.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  ApplySubsidyModel;

@interface ApplyInPutFrame : NSObject

@property (nonatomic, assign) CGRect typeTitleF;

@property (nonatomic, assign) CGRect youfeiF;

//@property (nonatomic, assign) CGRect baoxianF;

@property (nonatomic, assign) CGRect baoyangF;

//@property (nonatomic, assign) CGRect luntaiF;

@property (nonatomic, assign) CGRect xiuliF;

@property (nonatomic, assign) CGRect line1F;

@property (nonatomic, assign) CGRect countTitleF;

@property (nonatomic, assign) CGRect countF;

@property (nonatomic, assign) CGRect line2F;

@property (nonatomic, assign) CGRect InvoiceTitleF;

@property (nonatomic, assign) CGRect AddInvoiceBtnF;

@property (nonatomic, assign) CGRect InvoiceBGviewF;

@property (nonatomic, assign) CGRect SureBtnF;

@property (nonatomic, assign) CGRect SureBtnBGViewF;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) ApplySubsidyModel *applymodel;

@end
