//
//  ZZ_FriendCell.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "ZZ_FriendCell.h"
#import "ZZ_FriendModel.h"
#import "ZZ_FriendFrame.h"
#import "RedHorseHeader.h"

@interface ZZ_FriendCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *phoneLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation ZZ_FriendCell

+ (instancetype)ZZ_FriendCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"ZZ_FriendCell";
    
    ZZ_FriendCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[ZZ_FriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = ZZ_FunctionColor;
        
        name.font = ZZ_NameFont;
        
        [self addSubview:name];
        
        UILabel *phone = [[UILabel alloc] init];
        
        self.phoneLab = phone;
        
        phone.textColor = ZZ_PhoneColor;
        
        phone.font = ZZ_PhoneFont;
        
        [self addSubview:phone];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(ZZ_FriendFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.phoneLab.frame = self.frameModel.phoneF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    ZZ_FriendModel *model = self.frameModel.friendModel;
    
    self.iconImg.image = [UIImage imageNamed:model.iconImg];
    
    self.nameLab.text = model.friendName;
    
    self.phoneLab.text = model.friendPhone;
    
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
