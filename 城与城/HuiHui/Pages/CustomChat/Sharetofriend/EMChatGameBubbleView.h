//
//  EMChatDaliBubbleView.h
//  HuiHui
//
//  Created by 冯海强 on 15-1-28.
//  Copyright (c) 2015年 MaxLinksTec. All rights reserved.
//  自定义大众点评的view

#import "EMChatBaseBubbleView.h"
#import "GameResultLab.h"

extern NSString *const kRouterEventGameBubbleTapEventName;

@interface EMChatGameBubbleView : EMChatBaseBubbleView


@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UIImageView *iconImg;

@property (nonatomic, strong) GameResultLab *resultLab;

@end
