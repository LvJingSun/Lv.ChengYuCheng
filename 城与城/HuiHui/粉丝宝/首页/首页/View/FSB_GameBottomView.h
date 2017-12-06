//
//  FSB_GameBottomView.h
//  HuiHui
//
//  Created by mac on 2017/6/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSB_GameBottomView : UIView

@property (nonatomic, weak) UIButton *game1Btn;

@property (nonatomic, weak) UILabel *game1NameLab;

@property (nonatomic, weak) UIButton *game2Btn;

@property (nonatomic, weak) UILabel *game2NameLab;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t game1Block;

@property (nonatomic, copy) dispatch_block_t game2Block;

@end
