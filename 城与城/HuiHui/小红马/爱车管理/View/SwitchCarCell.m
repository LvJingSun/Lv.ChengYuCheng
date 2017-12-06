//
//  SwitchCarCell.m
//  HuiHui
//
//  Created by mac on 2017/6/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "SwitchCarCell.h"
#import "SwitchCarFrame.h"
#import "RH_CarModel.h"
#import "RedHorseHeader.h"

@interface SwitchCarCell ()

@property (nonatomic, weak) UILabel *line;

@property (nonatomic, weak) UIImageView *icon;

@property (nonatomic, weak) UILabel *carModelLab;

@property (nonatomic, weak) UILabel *carPlateLab;

@property (nonatomic, weak) UIImageView *statusImg;

@end

@implementation SwitchCarCell

+ (instancetype)SwitchCarCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"SwitchCarCell";
    
    SwitchCarCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[SwitchCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *line = [[UILabel alloc] init];
        
        self.line = line;
        
        line.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.icon = icon;
        
        [self addSubview:icon];
        
        UILabel *model = [[UILabel alloc] init];
        
        self.carModelLab = model;
        
        model.textColor = Administration_CarModelColor;
        
        model.font = Administration_CarModelFont;
        
        [self addSubview:model];
        
        UILabel *plate = [[UILabel alloc] init];
        
        self.carPlateLab = plate;
        
        plate.textColor = Administration_CarModelColor;
        
        plate.font = Administration_CarPlateFont;
        
        [self addSubview:plate];
        
        UIImageView *img = [[UIImageView alloc] init];
        
        self.statusImg = img;
        
        [self addSubview:img];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(SwitchCarFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.line.frame = self.frameModel.lineF;
    
    self.icon.frame = self.frameModel.imgF;
    
    self.carModelLab.frame = self.frameModel.carModelF;
    
    self.carPlateLab.frame = self.frameModel.carPlateF;
    
    self.statusImg.frame = self.frameModel.carStatusF;
    
}

- (void)setContent {
    
    RH_CarModel *model = self.frameModel.carmodel;
    
    [self.icon setImageWithURL:[NSURL URLWithString:model.carImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    self.carModelLab.text = model.carModel;
    
    self.carPlateLab.text = model.carPlate;
    
    if ([model.CarStatus isEqualToString:@"已拒绝"]) {
        
        self.carModelLab.textColor = Administration_NoDefaultTitleColor;
        
        self.carPlateLab.textColor = Administration_NoDefaultTitleColor;
        
        self.statusImg.image = [UIImage imageNamed:@"RH_未通过.png"];
        
    }else if ([model.CarStatus isEqualToString:@"审核中"]) {
        
        self.carModelLab.textColor = Administration_NoDefaultTitleColor;
        
        self.carPlateLab.textColor = Administration_NoDefaultTitleColor;
        
        self.statusImg.image = [UIImage imageNamed:@"RH_审核中.png"];
        
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
