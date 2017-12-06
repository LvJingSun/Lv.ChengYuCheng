//
//  BillAlertView.h
//  HuiHui
//
//  Created by mac on 2017/5/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BillOrderModel;

@protocol BillAlertViewDelegate <NSObject>

- (void)BillSureBtnClick;

@end

@interface BillAlertView : UIView

@property (nonatomic, strong) BillOrderModel *orderModel;

@property (nonatomic, strong) id<BillAlertViewDelegate> delegate;

- (void)showInView:(UIView *)view;

- (void)disMissView;

@end
