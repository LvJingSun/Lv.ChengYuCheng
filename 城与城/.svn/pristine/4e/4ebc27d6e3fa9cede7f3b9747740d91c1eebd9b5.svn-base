//
//  EMChatcustomBubbleView.m
//  HuiHui
//
//  Created by 冯海强 on 14-12-19.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "EMChatcustomBubbleView.h"
NSString *const kRouterEventcustomBubbleTapEventName = @"kRouterEventcustomBubbleTapEventName";

@interface EMChatcustomBubbleView ()

@property (nonatomic, strong) UIImageView *customImageView;
@property (nonatomic, strong) UILabel *customLabel;

@end

@implementation EMChatcustomBubbleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CUSTOM_IMAGEVIEW_SIZE, CUSTOM_IMAGEVIEW_SIZE)];
        [self addSubview:_customImageView];
        
        _customLabel = [[UILabel alloc] init];
        _customLabel.font = [UIFont systemFontOfSize:CUSTOM_ADDRESS_LABEL_FONT_SIZE];
        _customLabel.textColor = [UIColor blackColor];
        _customLabel.numberOfLines = 0;
        _customLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_customLabel];
    }
    return self;
}

-(CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(230, 81);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = CGRectMake(0, 0, CUSTOM_IMAGEVIEW_SIZE, CUSTOM_IMAGEVIEW_SIZE);
    
    if (self.model.isSender) {
        _customLabel.frame = CGRectMake(CUSTOM_IMAGEVIEW_SIZE + 2*BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING, 132, self.frame.size.height -2*BUBBLE_VIEW_PADDING);

        frame.origin.x = BUBBLE_VIEW_PADDING;
    }else{
        _customLabel.frame = CGRectMake( BUBBLE_ARROW_WIDTH +BUBBLE_VIEW_PADDING, BUBBLE_VIEW_PADDING, 132, self.frame.size.height -2*BUBBLE_VIEW_PADDING);

        frame.origin.x = BUBBLE_VIEW_PADDING +BUBBLE_ARROW_WIDTH + _customLabel.frame.size.width +BUBBLE_VIEW_PADDING;
    }
    
    frame.origin.y = BUBBLE_VIEW_PADDING;
    [self.customImageView setFrame:frame];
}

#pragma mark - setter

- (void)setModel:(MessageModel *)model
{
    [super setModel:model];
    
    _customLabel.text = model.PROtitle;

    UIImage *reSizeImage = [self.imageCache getImage:model.PROphotoURl];
    if (reSizeImage != nil) {
        _customImageView.image = reSizeImage;
        return;
    }
    [_customImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:model.PROphotoURl]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     
                                     _customImageView.image = image;
                                     
                                     [self.imageCache addImage:image andUrl:model.PROphotoURl];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     [_customImageView setImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]];
                                     
                                 }];
    
}

#pragma mark - public
-(void)bubbleViewPressed:(id)sender
{
    [self routerEventWithName:kRouterEventcustomBubbleTapEventName userInfo:@{KMESSAGEKEY:self.model}];
}

+(CGFloat)heightForBubbleWithObject:(MessageModel *)object
{
    return 2 * BUBBLE_VIEW_PADDING + CUSTOM_IMAGEVIEW_SIZE;
}


@end
