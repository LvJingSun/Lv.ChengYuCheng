//
//  ProductBigViewController.h
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//  大图展示

#import "BaseViewController.h"

#import "GrayPageControl.h"

#import "ImageCache.h"


@interface ProductBigViewController : BaseViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    
    IBOutlet    UIScrollView     *m_scrollView;    //图片滑动SCROLLVIEW
    GrayPageControl              *m_pageControl;   //计数器
    NSMutableArray               *bigImageList;    //图片数组

    
}

@property (nonatomic,strong) GrayPageControl       *m_pageControl;
@property (nonatomic,strong) NSMutableArray        *bigImageList;


@property (weak, nonatomic) ImageCache *imageCache;


- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
           imageArray:(NSMutableArray *)list;



@end
