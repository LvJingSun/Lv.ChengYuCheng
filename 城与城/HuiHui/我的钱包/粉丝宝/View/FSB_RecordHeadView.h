//
//  FSB_RecordHeadView.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SegmChangeBlock)(NSInteger i);

@interface FSB_RecordHeadView : UIView

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) SegmChangeBlock changeblock;

- (void)returnChangeValue:(SegmChangeBlock)block;

@end
