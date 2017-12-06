//
//  MessageListCell.h
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageObject.h"

#import "ImageCache.h"

#import "OHAttributedLabel.h"

//头像大小
#define HEAD_SIZE           50.0f
#define TEXT_MAX_HEIGHT     500.0f
//间距
#define INSETS              8.0f


@protocol LongPressGestureDelegate <NSObject>

- (void)showCopyAndForwarding:(NSString *)aIndex;

@end


@interface MessageListCell : UITableViewCell<UIGestureRecognizerDelegate,LongPressGestureDelegate>

{
    UIImageView     *_userHead;
    UIImageView     *_bubbleBg;
    UIImageView     *_headMask;
    UIImageView     *_chatImage;
    OHAttributedLabel         *_messageConent;
    
    UIImageView     *_voiceImage;
    UIButton        *_voiceBtn;
    
    UIButton        *_imageBtn;
    
    UIButton        *_headBtn;
}

@property (nonatomic) enum kWCMessageCellStyle  msgStyle;
@property (nonatomic) int height;

@property (nonatomic, strong) OHAttributedLabel  *_messageConent;

@property (nonatomic, strong) ImageCache        *imageCache;

@property (nonatomic, strong) UIButton          *_voiceBtn;

@property (nonatomic, strong) UIImageView       *_voiceImage;

@property (nonatomic, strong) UIButton          *_imageBtn;

@property (nonatomic, strong) UIButton          *_headBtn;


@property (nonatomic, strong) UIImageView       *_animationImagV;

@property (nonatomic, strong) UILabel           *_timeLabel;

@property (nonatomic, strong) UIImageView       *_bubbleBg;

@property (nonatomic, assign) id<LongPressGestureDelegate> delegate;


@property (nonatomic, strong) NSString *m_contentString;


- (void)setMessageObject:(MessageObject *)aMessage;
- (void)setHeadImage:(NSString *)headImage tag:(int)aTag;
- (void)setChatImage:(NSString *)chatImage tag:(int)aTag;


- (void)setHeadImageWithPath:(NSString *)headImage tag:(int)aTag;

- (void)setContent:(NSString *)content withRow:(NSInteger)aRow;

@end
