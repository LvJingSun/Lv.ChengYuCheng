//
//  Add_FriendsCell.m
//  HuiHui
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_FriendsCell.h"
#import "Add_MoreFriends.h"
#import "Add_ScrollFrame.h"
#import "UIImageView+AFNetworking.h"

#define NameColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define NameFont [UIFont systemFontOfSize:16]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@interface Add_FriendsCell ()

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UIButton *addBtn;

@end

@implementation Add_FriendsCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageview = [[UIImageView alloc] init];
        
        self.iconImageview = imageview;
        
        [self addSubview:imageview];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = NameColor;
        
        name.font = NameFont;
        
        name.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:name];
        
        UIButton *btn = [[UIButton alloc] init];
        
        self.addBtn = btn;
        
        [self addSubview:btn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Add_ScrollFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.iconImageview.frame = self.frameModel.iconF;
    
    self.iconImageview.layer.masksToBounds = YES;
    
    self.iconImageview.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.addBtn.frame = self.frameModel.addF;
    
    self.addBtn.layer.masksToBounds = YES;
    
    self.addBtn.layer.cornerRadius = 2;
    
    self.addBtn.layer.borderWidth = 1;
    
    self.addBtn.layer.borderColor = LineColor.CGColor;
    
}

- (void)setContent {
    
    Add_MoreFriends *ifriend = self.frameModel.friendModel;
    
//    self.iconImageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",ifriend.iconUrl]];
    
    [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ifriend.PhotoMidUrl]] placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",ifriend.NickName];
    
    [self.addBtn setTitle:@"添加" forState:0];
    
    [self.addBtn setTitleColor:[UIColor darkTextColor] forState:0];
    
}

@end
