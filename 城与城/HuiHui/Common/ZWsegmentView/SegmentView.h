//
//  SegmentView.h
//
//  Created by apple on 15-8-30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//  
#define kBtnWidth WindowSizeWidth/4
#define kBtnWidth1 67
#define kBtnWidth2 WindowSizeWidth/4
#define kBtnWidth3 WindowSizeWidth/5

#define kBtnHeight 35
#import <UIKit/UIKit.h>

@class SegmentView;

@protocol SegmentViewDelegate <NSObject>
- (void)segmentView:(SegmentView *)segmentView didSelectedSegmentAtIndex:(int)index;
@end

@interface SegmentView : UIView

- (id)initWithTitles:(NSArray *)titles withFram:(CGRect )Frame withBtnWidth:(CGFloat)BtnWidth andSelected:(BOOL)Selected;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<SegmentViewDelegate> delegate;

-(void)segemtBtnChange:(int)index;

@end