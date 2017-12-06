//
//  SegmentView.m
//
//  Created by apple on 15-8-30.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "SegmentView.h"
#import "UIImage+Fit.h"
@interface MyButton: UIButton
@end

@implementation MyButton
- (void)setHighlighted:(BOOL)highlighted{}
@end

@interface SegmentView()
{
    UIButton *_currentBtn;
    UIButton *_preformBtn;
    CGFloat SegmentWith;//总宽度
    CGFloat oneBtnWidth;//单个宽度
    
    BOOL isSelected;//是否需要设置选中颜色；
    
}
@end

@implementation SegmentView
- (id)initWithTitles:(NSArray *)titles withFram:(CGRect )Frame withBtnWidth:(CGFloat)BtnWidth andSelected:(BOOL)Selected;
{
    SegmentWith = Frame.size.width;
    oneBtnWidth = BtnWidth;
    isSelected = Selected;
    if (self = [super initWithFrame:Frame]) {
        self.titles = titles;
        self.tag=100;
    }
    return self;
}

- (void)btnDown:(UIButton *)btn
{
    if (btn == _currentBtn) return;
    _currentBtn.selected = NO;
    btn.selected = YES;
    _currentBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedSegmentAtIndex:)]) {
        [self.delegate segmentView:self didSelectedSegmentAtIndex:(int)btn.tag];
    }
}

-(void)segemtBtnChange:(int)index
{
    UIButton *btn=(UIButton *)[self viewWithTag:index];
    if (btn == _currentBtn) return;
    _currentBtn.selected = NO;
    btn.selected = YES;
    _currentBtn = btn;
    
}


- (void)setTitles:(NSArray *)titles
{
    // 数组内容一致，直接返回
    if ([titles isEqualToArray:_titles]) return;
    _titles = titles;
    // 1.移除所有的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 2.添加新的按钮
    NSInteger count = titles.count;
//    if (count==3) {
//        btnWidth=107;
//    }
    for (int i = 0; i<count; i++) {
        MyButton *btn = [MyButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        
        // 设置按钮的frame
        btn.frame = CGRectMake(i * oneBtnWidth, 0, oneBtnWidth, kBtnHeight);
//        NSString *normal = @"seg";
//        NSString *selected = @"segselect";
//        [btn setBackgroundImage:[UIImage resizeImage:normal] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage resizeImage:selected] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (isSelected) {
            [btn setBackgroundImage:[self createImageWithColor:RGBACOLOR(213, 213, 213, 1)] forState:UIControlStateSelected];
            // 设置文字
            // btn.adjustsImageWhenHighlighted = NO;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        }else{
            [btn setTitleColor:RGBACOLOR(100, 163, 243, 1) forState:UIControlStateSelected];
        }

        
        // 设置监听器
        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchDown];
        // 设置选中
        if (i == 0) {
            [self btnDown:btn];
        }
        // 添加按钮
        [self addSubview:btn];
    }
    self.bounds = CGRectMake(0, 0, SegmentWith, kBtnHeight);
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
