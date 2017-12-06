//
//  EmotionView.m
//  HuiHui
//
//  Created by mac on 14-7-2.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "EmotionView.h"
#import "Configuration.h"

static EmotionView *instance;

static id delegate;


@implementation EmotionView

+(void) setEmotionDelegate:(id) freshDelegate{
    
    delegate = freshDelegate;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (EmotionView *) instance{
    if (nil == instance) {
        
        EmotionView *sv = [[EmotionView alloc] initWithFrame:CGRectMake(0, 0, 320, 170)];
        sv.backgroundColor = [UIColor whiteColor];
        EmotionPanelView *eView = [[EmotionPanelView alloc] initWithFrame:CGRectMake(0, 0, 1920, 170)];
        sv.contentSize = eView.frame.size;
        sv.pagingEnabled = YES;
        [sv addSubview:eView];
        
        UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(141, 135, 38, 36)];
        pc.numberOfPages = 6;
        pc.currentPage = 1;
//        pc.backgroundColor = [UIColor blackColor];
//        [sv addSubview:pc];
        
        instance = sv;
        
    }
    return instance;
}
@end

@implementation EmotionPanelView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn0.frame =CGRectMake(0, 0, 2240, 170);
        btn0.backgroundColor = [UIColor clearColor];
        [self addSubview:btn0];
        
        for(int i=0; i<7; i++){
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = [UIImage imageNamed:@"e_delete_btn.png"];
                [btn addTarget:self
                        action:@selector(deleteEmotion)
              forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:image forState:UIControlStateNormal];
                btn.frame = CGRectMake(200+320*i, 118, 39, 39);
                [self addSubview:btn];
            }
            
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self
                        action:@selector(sendEmotion)
              forControlEvents:UIControlEventTouchUpInside];
                btn.frame = CGRectMake(260+320*i, 122, 55, 30);
                
                UIImage *img = [[UIImage imageNamed:@"blue_btn.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:12];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
                [btn setBackgroundImage:img forState:UIControlStateNormal];
                [btn setTitle:@"发送" forState:UIControlStateNormal];
                btn.layer.masksToBounds = YES;//设置圈角
                btn.layer.cornerRadius = 5.0;

                [self addSubview:btn];
            }
        }
        int x = 8, y= 20;
        int pageSpan = 0;
        for (int i=1000; i<1105; i++) {
            NSString *imageName = [NSString stringWithFormat:@"f%d.png",i];
            imageName = [imageName stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@""];
            UIImage *image = [UIImage imageNamed:imageName];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            [btn addTarget:self
                    action:@selector(clickedEmotion:)
          forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:image forState:UIControlStateNormal];
            btn.frame = CGRectMake(x+pageSpan, y, 30, 30);
            [self addSubview:btn];
            x += 46;
            if (i == 1017 || i == 1035 || i == 1053 || i == 1071 || i == 1089) {
               
                x+=138;
                
            }
            
            
            if (x == 330) {
                x = 8;
                y += 50;
                
                if (y == 170) {
                    y = 20;
                    pageSpan += 320;
                }
            }
        }
    }
    return self;
}

- (void)deleteEmotion{
    if (delegate && [delegate respondsToSelector:@selector(deleteEmotion)]) {
        [delegate performSelector:@selector(deleteEmotion) withObject:nil];
    }
}

- (void)sendEmotion{
    if (delegate && [delegate respondsToSelector:@selector(sendEmotion)]) {
        [delegate performSelector:@selector(sendEmotion) withObject:nil];
    }
}

- (void)clickedEmotion:(UIButton *) btn{
    
    NSString *name = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    
    name = [name substringFromIndex:1];
    
    NSString *text = [NSString stringWithFormat:@"/:HH%@:",name];
    
    if (delegate && [delegate respondsToSelector:@selector(clickedEmotion:)]) {
        
        [delegate performSelector:@selector(clickedEmotion:) withObject:text];
    }
}

@end

