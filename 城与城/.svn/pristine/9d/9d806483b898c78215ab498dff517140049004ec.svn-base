//
//  MessageListCell.m
//  HuiHui
//
//  Created by mac on 14-3-28.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "MessageListCell.h"

#import "UIImageView+AFNetworking.h"

#import "CommonUtil.h"

#import "NSData+Base64.h"

#import "MarkupParser.h"

#import "SCGIFImageView.h"

#define CELL_HEIGHT self.contentView.frame.size.height
#define CELL_WIDTH self.contentView.frame.size.width


@implementation MessageListCell

@synthesize _voiceBtn;

@synthesize _voiceImage;

@synthesize _imageBtn;

@synthesize _animationImagV;

@synthesize _timeLabel;

@synthesize _headBtn;

@synthesize _bubbleBg;

@synthesize delegate;

@synthesize _messageConent;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        _userHead = [[UIImageView alloc]initWithFrame:CGRectZero];
        _bubbleBg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _messageConent = [[OHAttributedLabel alloc]initWithFrame:CGRectZero];
        _headMask = [[UIImageView alloc]initWithFrame:CGRectZero];
        _chatImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _voiceImage = [[UIImageView alloc]initWithFrame:CGRectZero];
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _animationImagV = [[UIImageView alloc]initWithFrame:CGRectZero];
        
        _timeLabel = [[UILabel alloc]init];
        
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:10.0f];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.frame = CGRectMake(0, 2, 320, 10);
        _timeLabel.textColor = [UIColor grayColor];
        
        [_messageConent setBackgroundColor:[UIColor clearColor]];
        
        [self.contentView addSubview:_bubbleBg];
        [self.contentView addSubview:_userHead];
        [self.contentView addSubview:_headMask];
        [self.contentView addSubview:_chatImage];
        [self.contentView addSubview:_voiceImage];
        [self.contentView addSubview:_voiceBtn];
        [self.contentView addSubview:_imageBtn];
        [self.contentView addSubview:_headBtn];
        
        [self.contentView addSubview:_animationImagV];
        
        [self.contentView addSubview:_timeLabel];
        
        [self.contentView addSubview:_messageConent];

        
        // 添加长按的手势
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressHandle:)];
        [recognizer setMinimumPressDuration:0.4f];
        [self addGestureRecognizer:recognizer];

        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_headMask setImage:[[UIImage imageNamed:@""]stretchableImageWithLeftCapWidth:10 topCapHeight:10]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

// 长按手势
- (void)longPressHandle:(UITapGestureRecognizer *)longPressGestureRecognizer
{
    
    if (longPressGestureRecognizer.state != UIGestureRecognizerStateBegan )
        return;
    
    // 执行代理方法
    if ( delegate && [delegate respondsToSelector:@selector(showCopyAndForwarding:)] ) {
        
        [self.delegate performSelector:@selector(showCopyAndForwarding:) withObject:[NSString stringWithFormat:@"%i",self.tag]];
    }
   
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
//    NSString *orgin = self.m_contentString;
//    CGSize textSize = [orgin sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake((320-HEAD_SIZE-3*INSETS-40), TEXT_MAX_HEIGHT) lineBreakMode:NSLineBreakByWordWrapping];
    
    switch (_msgStyle) {
        case kWCMessageCellStyleMe:
        {
            [_chatImage setHidden:YES];
            [_voiceImage setHidden:YES];
            [_voiceBtn setHidden:YES];
            [_messageConent setHidden:NO];
            [_imageBtn setHidden:YES];
            
            [_animationImagV setHidden:YES];
            
//            [_messageConent setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-textSize.width-15, (CELL_HEIGHT-textSize.height)/2, _messageConent.frame.size.width, _messageConent.frame.size.height)];
            
            
            
            [_messageConent setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-_messageConent.frame.size.width-15,  (CELL_HEIGHT-_messageConent.frame.size.height)/2, _messageConent.frame.size.width, _messageConent.frame.size.height)];

            
            
            
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];
            [_headBtn setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"SenderTextNodeBkg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
//            _bubbleBg.frame = CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-12, textSize.width+30, textSize.height+30);
            
            _bubbleBg.frame = CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-10, _messageConent.frame.size.width + 30, _messageConent.frame.size.height+25);

            
        }
            break;
        case kWCMessageCellStyleOther:
        {
            [_chatImage setHidden:YES];
            [_voiceImage setHidden:YES];
            [_voiceBtn setHidden:YES];
            [_messageConent setHidden:NO];
            [_imageBtn setHidden:YES];

            [_animationImagV setHidden:YES];
            
            [_userHead setFrame:CGRectMake(INSETS, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_headBtn setFrame:CGRectMake(INSETS, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            
//            [_messageConent setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-textSize.height)/2, _messageConent.frame.size.width, _messageConent.frame.size.height)];
            
            
            [_messageConent setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-_messageConent.frame.size.height)/2, _messageConent.frame.size.width, _messageConent.frame.size.height)];

            
            [_bubbleBg setImage:[[UIImage imageNamed:@"ReceiverTextNodeBkg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
//            _bubbleBg.frame = CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-12, textSize.width+30, textSize.height+30);

            
            _bubbleBg.frame = CGRectMake(_messageConent.frame.origin.x-15, _messageConent.frame.origin.y-10, _messageConent.frame.size.width+30, _messageConent.frame.size.height+25);

            
            
        }
            break;
        case kWCMessageCellStyleMeWithImage:
        {

            [_chatImage setHidden:NO];
            [_voiceImage setHidden:YES];
            [_voiceBtn setHidden:YES];
            [_messageConent setHidden:YES];
            [_imageBtn setHidden:NO];
            
            [_animationImagV setHidden:YES];

            [_chatImage setFrame:CGRectMake(CELL_WIDTH-INSETS*2-HEAD_SIZE-115, (CELL_HEIGHT-100)/2, 100, 100)];
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_headBtn setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_bubbleBg setImage:[[UIImage imageNamed:@"SenderTextNodeBkg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            _bubbleBg.frame=CGRectMake(_chatImage.frame.origin.x-13, _chatImage.frame.origin.y-10, 100+30, 100+30);
            
            _imageBtn.frame=CGRectMake(_chatImage.frame.origin.x-13, _chatImage.frame.origin.y-10, 100+30, 100+30);

        }
            break;
        case kWCMessageCellStyleOtherWithImage:
        {
            [_chatImage setHidden:NO];
            [_voiceImage setHidden:YES];
            [_voiceBtn setHidden:YES];
            [_messageConent setHidden:YES];
            [_imageBtn setHidden:NO];
            
            
            [_animationImagV setHidden:YES];


            [_chatImage setFrame:CGRectMake(2*INSETS+HEAD_SIZE+15, (CELL_HEIGHT-100)/2,100,100)];
            [_userHead setFrame:CGRectMake(INSETS, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_headBtn setFrame:CGRectMake(INSETS, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_bubbleBg setImage:[[UIImage imageNamed:@"ReceiverTextNodeBkg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            
            _bubbleBg.frame=CGRectMake(_chatImage.frame.origin.x-17, _chatImage.frame.origin.y-10, 100+30, 100+30);

            
            _imageBtn.frame=CGRectMake(_chatImage.frame.origin.x-17, _chatImage.frame.origin.y-10, 100+30, 100+30);

        }
            break;

        case kWCMessageCellStyleMeWithVoice:
        {

            [_chatImage setHidden:YES];
            [_voiceImage setHidden:NO];
            [_voiceBtn setHidden:NO];
            [_messageConent setHidden:YES];
            [_imageBtn setHidden:YES];
            
            [_animationImagV setHidden:YES];

            [_voiceImage setImage:[UIImage imageNamed:@"SenderVoicePlay.png"]];
            [_userHead setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];
            [_headBtn setFrame:CGRectMake(CELL_WIDTH-INSETS-HEAD_SIZE, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];
            
            
            _voiceBtn.backgroundColor = [UIColor clearColor];
            
            [_bubbleBg setImage:[[UIImage imageNamed:@"SenderTextNodeBkg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            
            _bubbleBg.frame = CGRectMake(_userHead.frame.origin.x - 85, CELL_HEIGHT / 2 - 25, 80, 50);
            
            _voiceImage.frame = CGRectMake(_bubbleBg.frame.origin.x + 45, _bubbleBg.frame.origin.y + 10, 20, 20);
            
            _voiceBtn.frame = CGRectMake(_userHead.frame.origin.x - 85, CELL_HEIGHT / 2 - 25, 80, 50);
            
            
            _animationImagV.frame = CGRectMake(_bubbleBg.frame.origin.x + 45, _bubbleBg.frame.origin.y + 10, 20, 20);

        }
            break;
            
        case kWCMessageCellStyleOtherWithVoice:
        {
            [_chatImage setHidden:YES];
            [_voiceImage setHidden:NO];
            [_voiceBtn setHidden:NO];
            [_messageConent setHidden:YES];
            [_imageBtn setHidden:YES];
            
            [_animationImagV setHidden:YES];


            _voiceBtn.backgroundColor = [UIColor clearColor];

            [_voiceImage setImage:[UIImage imageNamed:@"ReceiverVoicePlay.png"]];

            [_userHead setFrame:CGRectMake(INSETS, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_headBtn setFrame:CGRectMake(INSETS, INSETS + 5,HEAD_SIZE , HEAD_SIZE)];

            [_bubbleBg setImage:[[UIImage imageNamed:@"ReceiverTextNodeBkg"]stretchableImageWithLeftCapWidth:20 topCapHeight:30]];
            
            _bubbleBg.frame = CGRectMake(_userHead.frame.origin.x + 55, CELL_HEIGHT / 2 - 25, 80, 50);
            
            _voiceImage.frame = CGRectMake(_bubbleBg.frame.origin.x + 15, _bubbleBg.frame.origin.y + 12, 20, 20);
            
            _voiceBtn.frame = CGRectMake(_userHead.frame.origin.x + 55, CELL_HEIGHT / 2 - 25, 80, 50);
            
            _animationImagV.frame = CGRectMake(_bubbleBg.frame.origin.x + 15, _bubbleBg.frame.origin.y + 12, 20, 20);
            
        }
            break;

        default:
            break;
    }
    
    
    _headMask.frame = CGRectMake(_userHead.frame.origin.x-3, _userHead.frame.origin.y-1, HEAD_SIZE+6, HEAD_SIZE+6);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setMessageObject:(MessageObject*)aMessage
{
        
    [_messageConent setText:aMessage.messageContent];
    
}

- (void)setContent:(NSString *)content withRow:(NSInteger)aRow{
    
    _messageConent.backgroundColor = [UIColor clearColor];
    
    self.m_contentString = content;
    
    _messageConent.tag = aRow;
    
    MarkupParser* p = [[MarkupParser alloc] init];
    
    // 清空数组重新赋值
    [p.images removeAllObjects];
    
    [_messageConent.imageInfoArr removeAllObjects];
    
    NSMutableAttributedString* attString = [p attrStringFromMarkup: content];
    CTFontRef verdana = CTFontCreateWithName((CFStringRef)@"Verdana",13,NULL);
    [attString addAttribute:(NSString*)(kCTFontAttributeName) value:(__bridge id)verdana range:NSMakeRange(0, attString.length)];
    
    [_messageConent setAttString:attString withImages:p.images];
    // 这个属性设置为YES时就表示可以对网址进行操作
    _messageConent.underlineLinks = YES;
    _messageConent.userInteractionEnabled = YES;
    
    CGRect labelRect = _messageConent.frame;
    
    labelRect.size.width = [_messageConent sizeThatFits:CGSizeMake(200, CGFLOAT_MAX)].width;
    labelRect.size.height = [_messageConent sizeThatFits:CGSizeMake(200, CGFLOAT_MAX)].height;
    
    CGFloat textX = 20;
    
    textX = 310 - labelRect.size.width - 10 - 10 - 3;
    
    labelRect.origin = CGPointMake(textX, 6);
    _messageConent.frame = labelRect;
    [_messageConent.layer display];
    
    
    if ( p.images.count != 0 ) {
        
        // 删除已经存在的图片
        for (SCGIFImageView *imageV in _messageConent.subviews) {
            
            [imageV removeFromSuperview];
            
        }
        
        for (NSArray *info in _messageConent.imageInfoArr) {
            
            NSString *filePath = [[NSBundle mainBundle] pathForResource:[info objectAtIndex:0] ofType:nil];
            
            NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
            
            SCGIFImageView *imageView = [[SCGIFImageView alloc] initWithGIFData:data];
            
            imageView.frame = CGRectFromString([info objectAtIndex:2]);
            
            [_messageConent addSubview:imageView];//label内添加图片层
            [_messageConent bringSubviewToFront:imageView];
            
        }
    }else{
        
        for (UIImageView *imageV in _messageConent.subviews) {
            
            [imageV removeFromSuperview];
        }
        
    }
    
}

- (void)setHeadImage:(NSString *)headImage tag:(int)aTag
{
    [_userHead setTag:aTag];
//    [_userHead setWebImage:headImage placeHolder:Nil downloadFlag:aTag];
    
    
    
    UIImage *reSizeImage = [self.imageCache getImage:headImage];
    if (reSizeImage != nil) {
        _userHead.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak MessageListCell *weakCell = self;
    [_userHead setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                     placeholderImage:[UIImage imageNamed:@"moren.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                  _userHead.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                  //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                  [weakCell setNeedsLayout];
                                  [self.imageCache addImage:_userHead.image andUrl:headImage];
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                  
                              }];
    
    
    
}

- (void)setHeadImageWithPath:(NSString *)headImage tag:(int)aTag
{
    [_userHead setTag:aTag];
    //    [_userHead setWebImage:headImage placeHolder:Nil downloadFlag:aTag];
    
    
    UIImage *reSizeImage = [self.imageCache getImage:headImage];
    if (reSizeImage != nil) {
        _userHead.image = reSizeImage;
        return;
    }
    //NSLog(@"AFImage load path: %@", path);
    __weak MessageListCell *weakCell = self;
    [_userHead setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:headImage]]
                     placeholderImage:[UIImage imageNamed:@"moren.png"]
                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                  _userHead.image = [CommonUtil scaleImage:image toSize:CGSizeMake(60, 60)];
                                  
                                  _userHead.image = image;
                                 
                                  _userHead.contentMode = UIViewContentModeScaleAspectFit;
                                  
                                  //                                      self.m_imagV.contentMode = UIViewContentModeCenter;
                                  [weakCell setNeedsLayout];
                                  [self.imageCache addImage:_userHead.image andUrl:headImage];
                              }
                              failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                  
                              }];
    
    
    
}

- (void)setChatImage:(NSString *)chatImage tag:(int)aTag
{
    [_chatImage setTag:aTag];

    // 将NSData类型转换成UIImage进行赋值
    NSData *data = [NSData dataFromBase64String:chatImage];
    
    UIImage *image = [UIImage imageWithData:data];
    
    _chatImage.image = image;
    
    _chatImage.contentMode = UIViewContentModeScaleAspectFit;
    
}

- (void)showCopyAndForwarding:(NSString *)aIndex{
    
    
}

@end
