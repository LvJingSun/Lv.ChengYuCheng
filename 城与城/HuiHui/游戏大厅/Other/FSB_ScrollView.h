//
//  FSB_ScrollView.h
//  HuiHui
//
//  Created by mac on 2017/5/17.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    FFScrollViewSelecttionTypeTap = 100,  //默认的为可点击模式
    FFScrollViewSelecttionTypeNone   //不可点击的
}FFScrollViewSelecttionType;

@protocol FFScrollViewDelegate <NSObject>

@optional
- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber;

@end

@interface FSB_ScrollView : UIView <UIScrollViewDelegate>
{
    NSTimer *timer;
    NSArray *sourceArr;
}

@property(strong,nonatomic) UIScrollView *scrollView;
@property(strong,nonatomic) UIPageControl *pageControl;
@property(assign,nonatomic) FFScrollViewSelecttionType selectionType;
@property(assign,nonatomic) id <FFScrollViewDelegate> pageViewDelegate;

//@property (nonatomic, strong) NSArray *imageArray;

- (id)initPageViewWithFrame:(CGRect)frame views:(NSArray *)views;

@end
