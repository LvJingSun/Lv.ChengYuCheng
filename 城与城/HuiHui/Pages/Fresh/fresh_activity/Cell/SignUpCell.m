//
//  SignUpCell.m
//  HuiHui
//
//  Created by mac on 14-10-22.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "SignUpCell.h"

@implementation SignUpCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



@implementation SignListCell

- (void)awakeFromNib
{
    // Initialization code
    
    // 设置view的边框
    self.m_backView.layer.borderWidth = 1.0;
    self.m_backView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation SignDetailCell

- (void)awakeFromNib
{
    // Initialization code
    
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)getSignView:(NSMutableArray *)array{
    
    // 先删除已经加上来的view
    for (id view in self.subviews) {
        
        if ( [view isKindOfClass:[SignView class]] ) {
            
            [view removeFromSuperview];
        }
    }
    
    
    for (int i = 0; i < array.count; i ++) {
        
        SignView *signView = [[SignView alloc]initWithFrame:CGRectMake(10, 44 * i, 300, 44)];
        
        signView.backgroundColor = [UIColor whiteColor];
        
        signView.m_nameLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        
        signView.m_timeLabel.text = @"10-22";
        
        // 将重复的地方重叠起来，设置隐藏view的下面的虚线框
        if ( i == 0 ) {
            
            signView.frame = CGRectMake(10, 44 * i, 300, 44);
            
        }else{
            
            signView.frame = CGRectMake(10, 43 * i, 300, 44);

            
        }
        
        [self addSubview:signView];

    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44 * array.count);
    
}

@end

@implementation SignView

@synthesize m_nameLabel;

@synthesize m_timeLabel;


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
   
    if (self) {
        // Initialization code
        
        // 设置view的边框
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
        
        self.m_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 11, 195, 21)];
        self.m_nameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.m_nameLabel.textColor = [UIColor blackColor];
        self.m_nameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.m_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 11, 85, 21)];
        self.m_timeLabel.font = [UIFont systemFontOfSize:14.0f];
        self.m_timeLabel.textColor = [UIColor colorWithRed:182/255.0 green:182/255.0 blue:183/255.0 alpha:1.0];
        self.m_timeLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:self.m_nameLabel];
        [self addSubview:self.m_timeLabel];
        
    }
    
    return self;
}



@end

@implementation PartyCommentCell

- (void)awakeFromNib
{
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end