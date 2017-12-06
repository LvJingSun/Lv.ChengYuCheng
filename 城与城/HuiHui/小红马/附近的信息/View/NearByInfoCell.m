//
//  NearByInfoCell.m
//  HuiHui
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "NearByInfoCell.h"
#import "NearByInfoModel.h"
#import "NearByInfoFrame.h"
#import "RedHorseHeader.h"

@interface NearByInfoCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *addressLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UIButton *daoHangBtn;

@end

@implementation NearByInfoCell

+ (instancetype)NearByInfoCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"NearByInfoCell";
    
    NearByInfoCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[NearByInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.font = [UIFont systemFontOfSize:17];
        
        name.textColor = [UIColor blackColor];
        
        [self addSubview:name];
        
        UILabel *address = [[UILabel alloc] init];
        
        self.addressLab = address;
        
        address.font = [UIFont systemFontOfSize:15];
        
        address.textColor = [UIColor colorWithRed:92/255. green:89/255. blue:89/255. alpha:1];
        
        [self addSubview:address];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:line];
        
        UIButton *daohang = [[UIButton alloc] init];
        
        self.daoHangBtn = daohang;
        
        [self addSubview:daohang];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(NearByInfoFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.addressLab.frame = self.frameModel.addressF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.daoHangBtn.frame = self.frameModel.daohangF;
    
}

- (void)setContent {

    NearByInfoModel *model = self.frameModel.infoModel;
    
    self.iconImg.image = [UIImage imageNamed:model.picUrl];
    
    self.nameLab.text = model.name;
    
    self.addressLab.text = model.address;
    
    [self.daoHangBtn setImage:[UIImage imageNamed:@"Near_location.png"] forState:0];
    
    [self.daoHangBtn addTarget:self action:@selector(daohangClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)daohangClick {

    if (self.daoHaoBlock) {
        
        self.daoHaoBlock();
        
    }
    
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
