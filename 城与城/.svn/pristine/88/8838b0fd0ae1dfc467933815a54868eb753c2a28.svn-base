//
//  MoreView.h
//  HuiHuiApp
//
//  Created by mac on 13-10-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MoreviewDelegate <NSObject>

@optional

- (void)pickPhotoWithTag:(NSString *)aTag;

@end

@interface MoreView : UIView


@property (nonatomic,assign) id<MoreviewDelegate> m_delegate;

+ (MoreView *) instance;

+ (void) setDelegate:(id) delegate;

@end






