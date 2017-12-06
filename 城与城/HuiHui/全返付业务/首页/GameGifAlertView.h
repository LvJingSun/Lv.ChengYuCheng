//
//  GameGifAlertView.h
//  ewfqe
//
//  Created by mac on 2017/5/22.
//  Copyright © 2017年 lvjing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GifViewDelegate <NSObject>

- (void)GifViewClick;

@end

@interface GameGifAlertView : UIView

/*
 * @brief desingated initializer
 */
- (id)initWithCenter:(CGPoint)center fileURL:(NSURL*)fileURL;
/*
 * @brief start Gif Animation
 */
- (void)startGif;
/*
 * @brief stop Gif Animation
 */
- (void)stopGif;
/*
 * @brief get frames image(CGImageRef) in Gif
 */
+ (NSArray*)framesInGif:(NSURL*)fileURL;

@property (nonatomic, strong) id<GifViewDelegate> delegate;

@end
