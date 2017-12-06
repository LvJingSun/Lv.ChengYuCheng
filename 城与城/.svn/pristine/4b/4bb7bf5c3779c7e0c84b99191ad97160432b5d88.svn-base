//
//  CommentDetailCell.m
//  HuiHui
//
//  Created by mac on 14-10-23.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "CommentDetailCell.h"

@implementation CommentDetailCell

@synthesize m_commentArray;

@synthesize delegate;

- (void)awakeFromNib
{
    // Initialization code
    m_commentArray = [[NSMutableArray alloc]initWithCapacity:0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)getCommentView:(NSMutableArray *)array{
    
    // 先删除已经加上来的view
    for (id view in self.subviews) {
        
        if ( [view isKindOfClass:[CommentDetailView class]] ) {
            
            [view removeFromSuperview];
        }
    }
    
    self.m_commentArray = array;
    
    float sum = 1.0f;
    
    for (int i = 0; i < self.m_commentArray.count; i ++) {
        
        NSDictionary *dic = [self.m_commentArray objectAtIndex:i];
        
        CommentDetailView *commentView = [[CommentDetailView alloc]initWithFrame:CGRectMake(10, sum -1, 300, 44)];
        
        commentView.backgroundColor = [UIColor whiteColor];
        
        commentView.m_nameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"NickName"]];
        
        commentView.m_timeLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"TimeKey"]];
        
        commentView.m_content.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Content"]];
        
        
        CGSize size = [commentView.m_content.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        commentView.m_content.frame = CGRectMake(commentView.m_content.frame.origin.x, commentView.m_content.frame.origin.y, commentView.m_content.frame.size.width, size.height);
        
        commentView.frame = CGRectMake(10, sum, 300, 38 + size.height);
        
        commentView.m_btn.frame = CGRectMake(0, 0, 300, commentView.frame.size.height);
        commentView.m_btn.backgroundColor = [UIColor clearColor];
        
        
        commentView.m_btn.tag = i;
        [commentView.m_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        sum = sum + commentView.frame.size.height - 1;

        [self addSubview:commentView];
        
    }
    
}

- (void)btnClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSLog(@"tag = %i",btn.tag);
    
    if ( self.m_commentArray.count != 0 ) {
        
        NSDictionary *dic = [self.m_commentArray objectAtIndex:btn.tag];

        if ( delegate && [delegate respondsToSelector:@selector(partyCommentClicked:)] ) {
            
            [delegate performSelector:@selector(partyCommentClicked:) withObject:dic];
            
        }
    }
    
    
    
}

@end


@implementation CommentDetailView

@synthesize m_nameLabel;

@synthesize m_timeLabel;

@synthesize m_btn;

@synthesize m_content;


- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        
        // 设置view的边框
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;
        
        self.m_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 195, 21)];
        self.m_nameLabel.font = [UIFont systemFontOfSize:14.0f];
        self.m_nameLabel.textColor = [UIColor colorWithRed:96/255.0 green:207/255.0 blue:248/255.0 alpha:1.0];
        self.m_nameLabel.textAlignment = NSTextAlignmentLeft;
        
        self.m_timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 5, 85, 21)];
        self.m_timeLabel.font = [UIFont systemFontOfSize:14.0f];
        self.m_timeLabel.textColor = [UIColor colorWithRed:182/255.0 green:182/255.0 blue:183/255.0 alpha:1.0];
        self.m_timeLabel.textAlignment = NSTextAlignmentRight;

        self.m_content = [[UILabel alloc]initWithFrame:CGRectMake(5, 30, 290, 21)];
        self.m_content.font = [UIFont systemFontOfSize:14.0f];
        self.m_content.textColor = [UIColor blackColor];
        self.m_content.textAlignment = NSTextAlignmentLeft;
        self.m_content.numberOfLines = 0;
        
        self.m_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.m_btn.frame = CGRectMake(0, 0, 300, 30);
        self.m_btn.backgroundColor = [UIColor clearColor];

        [self addSubview:self.m_nameLabel];
        [self addSubview:self.m_timeLabel];
        [self addSubview:self.m_content];
        [self addSubview:self.m_btn];
        
    }
    
    return self;
}



@end
