//
//  GoldTranHeadView.h
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol TranTypeSegmDelegate <NSObject>
//
//- (void)TranTypeChange:(UISegmentedControl *)segmented;
//
//@end

typedef void(^SegmChangeBlock)(NSInteger i);

@interface GoldTranHeadView : UIView

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) SegmChangeBlock changeblock;

- (void)returnChangeValue:(SegmChangeBlock)block;

//@property (nonatomic, weak) id<TranTypeSegmDelegate> delegate;

@end
