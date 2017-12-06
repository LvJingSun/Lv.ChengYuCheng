//
//  MoreView.m
//  HuiHuiApp
//
//  Created by mac on 13-10-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "MoreView.h"

static MoreView *instance;
static id delegate;



@implementation MoreView

@synthesize m_delegate;

+(MoreView *) instance{
    if (nil == instance) {
        MoreView *sv = [[MoreView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        sv.backgroundColor = [UIColor whiteColor];
      
        instance = sv;
        
    }
    return instance;
}


+(void) setDelegate:(id) freshDelegate{
    
    delegate = freshDelegate;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        // 图片的按钮
        UIButton *PhotographBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        PhotographBtn.frame = CGRectMake(16, 10, 50, 50);
        PhotographBtn.backgroundColor = [UIColor clearColor];
        PhotographBtn.tag = 101;
        [PhotographBtn setBackgroundImage:[UIImage imageNamed:@"tupian.png"] forState:UIControlStateNormal];
        [PhotographBtn addTarget:self action:@selector(takePhotoes:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:PhotographBtn];
        
        // 图片所在的label
        UILabel *pictureLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 60, 50, 21)];
        pictureLabel.textAlignment = NSTextAlignmentCenter;
        pictureLabel.text = @"图片";
        pictureLabel.font = [UIFont systemFontOfSize:12.0f];
        
        [self addSubview:pictureLabel];
        
        // 拍照的按钮
        UIButton *PhotoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        PhotoBtn.frame = CGRectMake(92, 10, 50, 50);
        PhotoBtn.backgroundColor = [UIColor clearColor];
        PhotoBtn.tag = 100;
        
        [PhotoBtn setBackgroundImage:[UIImage imageNamed:@"paizhao.png"] forState:UIControlStateNormal];
        [PhotoBtn addTarget:self action:@selector(takePhotoes:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:PhotoBtn];
        
        
        // 图片所在的label
        UILabel *cameraLabel = [[UILabel alloc]initWithFrame:CGRectMake(92, 60, 50, 21)];
        cameraLabel.textAlignment = NSTextAlignmentCenter;
        cameraLabel.text = @"拍照";
        cameraLabel.font = [UIFont systemFontOfSize:12.0f];
        
        [self addSubview:cameraLabel];
        
        // 名片的按钮
        UIButton *cardBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cardBtn.frame = CGRectMake(168, 10, 60, 60);
        cardBtn.tag = 102;
        [cardBtn setTitle:@"名片" forState:UIControlStateNormal];
        [cardBtn addTarget:self action:@selector(takePhotoes:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:cardBtn];
        
        // 位置的按钮
        UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        locationBtn.frame = CGRectMake(244, 10, 60, 60);
        locationBtn.tag = 103;
        [locationBtn setTitle:@"位置" forState:UIControlStateNormal];
        [locationBtn addTarget:self action:@selector(takePhotoes:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:locationBtn];
        
    }
    return self;
}


- (void)takePhotoes:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    if ( m_delegate && [m_delegate respondsToSelector:@selector(pickPhotoWithTag:)] ) {
        
        [m_delegate performSelector:@selector(pickPhotoWithTag:) withObject:[NSString stringWithFormat:@"%i",btn.tag]];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
