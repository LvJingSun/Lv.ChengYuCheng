//
//  Car_ListCell.m
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Car_ListCell.h"
#import "Car_ListFrame.h"
#import "RH_CarModel.h"
#import "RedHorseHeader.h"

@interface Car_ListCell ()

@property (nonatomic, weak) UILabel *line;

@property (nonatomic, weak) UIImageView *icon;

@property (nonatomic, weak) UIButton *defaultBtn;

@property (nonatomic, weak) UILabel *defaultLab;

@property (nonatomic, weak) UILabel *carModelLab;

@property (nonatomic, weak) UILabel *carPlateLab;

@property (nonatomic, weak) UIImageView *statusImg;

@end

@implementation Car_ListCell

+ (instancetype)Car_ListCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Car_ListCell";
    
    Car_ListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Car_ListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *line = [[UILabel alloc] init];
        
        self.line = line;
        
        line.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.icon = icon;
        
        [self addSubview:icon];
        
        UIButton *defaultBtn = [[UIButton alloc] init];
        
        self.defaultBtn = defaultBtn;
        
        [defaultBtn addTarget:self action:@selector(defaultClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:defaultBtn];
        
        UILabel *defaultLab = [[UILabel alloc] init];
        
        self.defaultLab = defaultLab;
        
        defaultLab.font = Administration_DefaultTitleFont;
        
        [self addSubview:defaultLab];
        
        UILabel *model = [[UILabel alloc] init];
        
        self.carModelLab = model;
        
        model.textColor = Administration_CarModelColor;
        
        model.font = Administration_CarModelFont;
        
        [self addSubview:model];
        
        UILabel *plate = [[UILabel alloc] init];
        
        self.carPlateLab = plate;
        
        plate.textColor = Administration_CarPlateColor;
        
        plate.font = Administration_CarPlateFont;
        
        [self addSubview:plate];
        
        UIImageView *img = [[UIImageView alloc] init];
        
        self.statusImg = img;
        
        [self addSubview:img];
        
    }
    
    return self;
    
}

- (void)defaultClick:(UIButton *)sender {

    if (self.DefaultBlock) {
        
        self.DefaultBlock();
        
    }
    
}

-(void)setFrameModel:(Car_ListFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.line.frame = self.frameModel.lineF;
    
    self.icon.frame = self.frameModel.imgF;
    
    self.defaultBtn.frame = self.frameModel.defaultImgF;
    
    self.defaultLab.frame = self.frameModel.defaultTitleF;
    
    self.carModelLab.frame = self.frameModel.carModelF;
    
    self.carPlateLab.frame = self.frameModel.carPlateF;
    
    self.statusImg.frame = self.frameModel.carStatusF;
    
}

- (void)setContent {

    RH_CarModel *model = self.frameModel.carmodel;
    
    [self.icon setImageWithURL:[NSURL URLWithString:model.carImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    self.carModelLab.text = model.carModel;
    
    self.carPlateLab.text = model.carPlate;
    
    if ([model.isDefault isEqualToString:@"1"]) {
        
        [self.defaultBtn setImage:[UIImage imageNamed:@"Administration_default.png"] forState:0];
        
        self.defaultBtn.userInteractionEnabled = NO;
        
        self.defaultLab.text = @"默认车辆";
        
        self.defaultLab.textColor = Administration_DefaultTitleColor;
        
    }else if ([model.isDefault isEqualToString:@"0"]) {
    
        [self.defaultBtn setImage:[UIImage imageNamed:@"Administration_nodefault.png"] forState:0];
        
        self.defaultBtn.userInteractionEnabled = YES;
        
        self.defaultLab.text = @"设为默认";
        
        self.defaultLab.textColor = Administration_NoDefaultTitleColor;
        
    }
    
    if ([model.CarStatus isEqualToString:@"已拒绝"]) {
        
        self.statusImg.image = [UIImage imageNamed:@"RH_未通过.png"];
        
    }else if ([model.CarStatus isEqualToString:@"审核中"]) {
    
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
