//
//  GrayPageControl.m
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "GrayPageControl.h"


#define isSystemIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)

@implementation GrayPageControl

@synthesize inactiveImage;
@synthesize activeImage;

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
	{
		self.activeImage = nil;
		self.inactiveImage = nil;
	}
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
	{
		self.activeImage = nil;
		self.inactiveImage = nil;
    }
    return self;
}

-(void) updateDots
{
	if( !activeImage || !inactiveImage )
		return;
    
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView *dotView = [self.subviews objectAtIndex:i];
        UIImageView *dot = nil;
        
        // 在7以下，self.subviews里面的是UIImageView，7以上是UIView
        for (UIView *subview in dotView.subviews){
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
            [dotView addSubview:dot];
        }
        
        if (i == self.currentPage)
        {
            dot.image = activeImage;
        } else {
            dot.image = inactiveImage;
        }
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
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
