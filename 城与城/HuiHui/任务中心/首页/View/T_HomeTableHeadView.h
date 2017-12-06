//
//  T_HomeTableHeadView.h
//  HuiHui
//
//  Created by mac on 2017/3/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class T_BtnView;

@interface T_HomeTableHeadView : UIView

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, strong) T_BtnView *DFB_Btn;

@property (nonatomic, strong) T_BtnView *MY_Btn;

@property (nonatomic, strong) T_BtnView *FRIEND_Btn;

@property (nonatomic, assign) CGFloat height;

@end
