//
//  CustomNavigationBar.m
//  HuiHui
//
//  Created by mac on 13-10-11.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "CustomNavigationBar.h"

@interface CustomNavigationBar ()

@property (nonatomic, retain) UIImageView *backgroundImageView;
@property (nonatomic, retain) NSMutableDictionary *backgroundImages;


- (void)updateBackgroundImage;


@end


@implementation CustomNavigationBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Background Image
- (NSMutableDictionary *)backgroundImages
{
    if (_backgroundImages == nil){
        _backgroundImages = [[NSMutableDictionary alloc] init];
    }
    
    return _backgroundImages;
}

- (UIImageView *)backgroundImageView{
    
    if ( _backgroundImageView == nil ) {
        
        _backgroundImageView = [[UIImageView alloc]initWithFrame:[self bounds]];
        
        [_backgroundImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [self insertSubview:_backgroundImageView aboveSubview:0];
        
    }
    
    return _backgroundImageView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics{
    
    if ( [UINavigationBar instancesRespondToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [super setBackgroundImage:backgroundImage forBarMetrics:barMetrics];
   
    }else{
        
        [[self backgroundImages]setObject:backgroundImage forKey:[NSNumber numberWithInt:barMetrics]];
        
        [self updateBackgroundImage];
        
    }
    
}

- (void)updateBackgroundImage{
    
    UIBarMetrics metrics = ([self bounds].size.height > 40.0) ? UIBarMetricsDefault : UIBarMetricsLandscapePhone;
    
    UIImage *image = [[self backgroundImages]objectForKey:[NSNumber numberWithInt:metrics]];
    
    if ( image == nil && metrics != UIBarMetricsDefault ) {
        
        image = [[self backgroundImages]objectForKey:[NSNumber numberWithInt:UIBarMetricsDefault]];
    }
    
    if ( image != nil ) {
        
        [[self backgroundImageView] setImage:image];
    }
    
    
}

#pragma mark - Layout
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if ( _backgroundImageView != nil ) {
        
        [self updateBackgroundImage];
        
        [self sendSubviewToBack:_backgroundImageView];
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
