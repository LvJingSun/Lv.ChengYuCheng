//
//  EMChatcustomBubbleView.h
//  HuiHui
//
//  Created by 冯海强 on 14-12-19.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//  自定义产品的view

#import "EMChatBaseBubbleView.h"
#import "ImageCache.h"
#import "UIImageView+AFNetworking.h"
#import "CommonUtil.h"


#define CUSTOM_IMAGEVIEW_SIZE 65 // 产品图片大小

#define CUSTOM_ADDRESS_LABEL_FONT_SIZE  12 // 位置字体大小

extern NSString *const kRouterEventcustomBubbleTapEventName;

@interface EMChatcustomBubbleView : EMChatBaseBubbleView

@property (weak, nonatomic) ImageCache *imageCache;

@end
