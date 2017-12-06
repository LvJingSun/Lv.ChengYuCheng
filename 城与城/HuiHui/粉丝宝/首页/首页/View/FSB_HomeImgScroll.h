//
//  FSB_HomeImgScroll.h
//  HuiHui
//
//  Created by mac on 2017/7/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeScrollViewDelegate <NSObject>

- (void)HomeScrollDidSelected:(NSInteger)index;

@end

@interface FSB_HomeImgScroll : UIView

- (void)showInView:(UIView *)view;

@property (nonatomic, strong) id<HomeScrollViewDelegate> delegate;

@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic, assign) int countDown;

@property (nonatomic, copy) dispatch_block_t dismissBlock;

@end
