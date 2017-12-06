//
//  C_FriendCell.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "C_FriendCell.h"
#import "I_Friend.h"
#import "C_FriendFrame.h"
#import "UIImageView+AFNetworking.h"

@interface C_FriendCell ()

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UIButton *deleteBtn;

@end

@implementation C_FriendCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        self.iconImageview = imageview;
        
        [self addSubview:imageview];
        
        UIButton *btn = [[UIButton alloc] init];
        
        self.deleteBtn = btn;
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(C_FriendFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImageview.frame = self.frameModel.iconF;
    
    self.iconImageview.layer.masksToBounds = YES;
    
    self.iconImageview.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.deleteBtn.frame = self.frameModel.iconF;
    
    self.deleteBtn.layer.masksToBounds = YES;
    
    self.deleteBtn.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
}

- (void)setContent {

    I_Friend *ifriend = self.frameModel.friendModel;
    
    [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ifriend.PhotoUrl]] placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    [self.deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(deleteInvitationFriend:)]) {
        
        [self.delegate deleteInvitationFriend:sender];
        
    }
    
}

@end
