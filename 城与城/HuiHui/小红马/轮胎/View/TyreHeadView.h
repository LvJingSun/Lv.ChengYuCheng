//
//  TyreHeadView.h
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TyreView;

@interface TyreHeadView : UIView

@property (nonatomic, weak) TyreView *luntai1view;

@property (nonatomic, weak) TyreView *luntai2view;

@property (nonatomic, weak) TyreView *luntai3view;

@property (nonatomic, weak) TyreView *luntai4view;

@property (nonatomic, assign) CGFloat height;

@end
