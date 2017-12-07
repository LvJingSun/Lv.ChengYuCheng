//
//  HL_MyInfoHeadView.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HL_MyInfoHeadView : UIView

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *IDLab;

@property (nonatomic, weak) UIButton *bingBtn;

@property (nonatomic, weak) UILabel *roomcard;

@property (nonatomic, weak) UILabel *yuanbao;

@property (nonatomic, copy) NSString *type; //0-未绑定 1-已绑定

@property (nonatomic, assign) CGFloat height;

@end
