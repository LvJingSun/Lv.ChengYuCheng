//
//  InsuranceTypeAlertView.h
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InsuranceTypeModel;

typedef void(^ChooseTypeBlock) (InsuranceTypeModel *typemodel);

@interface InsuranceTypeAlertView : UIView

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) ChooseTypeBlock choosetype;

- (void)returnType:(ChooseTypeBlock)block;

- (void)showInView:(UIView *)view;

@end
