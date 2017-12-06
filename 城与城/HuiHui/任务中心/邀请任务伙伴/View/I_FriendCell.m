//
//  I_FriendCell.m
//  HuiHui
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "I_FriendCell.h"
#import "I_Friend.h"
#import "I_FriendFrame.h"
#import "UIImageView+AFNetworking.h"


#define NickColor [UIColor colorWithRed:23/255. green:44/255. blue:56/255. alpha:1.]
#define NickFont [UIFont systemFontOfSize:17]
#define NameColor [UIColor colorWithRed:163/255. green:163/255. blue:163/255. alpha:1.]
#define NameFont [UIFont systemFontOfSize:16]
#define PhoneFont [UIFont systemFontOfSize:14]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]

@interface I_FriendCell ()

@property (nonatomic, weak) UIImageView *chooseImageview;

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nickLab;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *phoneLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation I_FriendCell

+ (instancetype)I_FriendCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"I_FriendCell";
    
    I_FriendCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[I_FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *choose = [[UIImageView alloc] init];
        
        self.chooseImageview = choose;
        
        [self addSubview:choose];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImageview = icon;
        
        [self addSubview:icon];
        
        UILabel *nick = [[UILabel alloc] init];
        
        self.nickLab = nick;
        
        nick.textColor = NickColor;
        
        nick.font = NickFont;
        
        [self addSubview:nick];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = NameColor;
        
        name.font = NameFont;
        
        [self addSubview:name];
        
        UILabel *phone = [[UILabel alloc] init];
        
        self.phoneLab = phone;
        
        phone.textColor = NameColor;
        
        phone.font = PhoneFont;
        
        [self addSubview:phone];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(I_FriendFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.chooseImageview.frame = self.frameModel.chooseF;
    
    self.iconImageview.frame = self.frameModel.iconF;
    
    self.nickLab.frame = self.frameModel.nickF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.phoneLab.frame = self.frameModel.phoneF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    I_Friend *i_friend = self.frameModel.friendModel;
    
    if (i_friend.isChoose) {
        
        self.chooseImageview.image = [UIImage imageNamed:@"T_Selected.png"];
        
    }else {
    
        self.chooseImageview.image = [UIImage imageNamed:@"T_NoSelect.png"];
        
    }
    
    [self.iconImageview setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",i_friend.PhotoUrl]] placeholderImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    self.nickLab.text = [NSString stringWithFormat:@"%@",i_friend.NickName];
    
    self.nameLab.text = [NSString stringWithFormat:@"(%@)",i_friend.RealName];
    
    self.phoneLab.text = [NSString stringWithFormat:@"%@",i_friend.InvitePhone];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
