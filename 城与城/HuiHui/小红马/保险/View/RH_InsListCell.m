//
//  RH_InsListCell.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_InsListCell.h"
#import "RH_InsListModel.h"
#import "RH_InsListFrame.h"
#import "RedHorseHeader.h"

@interface RH_InsListCell ()

@property (nonatomic, weak) UILabel *CoTitleLab;

@property (nonatomic, weak) UILabel *CoLab;

@property (nonatomic, weak) UILabel *TimeTitleLab;

@property (nonatomic, weak) UILabel *TimeLab;

@property (nonatomic, weak) UILabel *CountTitleLab;

@property (nonatomic, weak) UILabel *CountLab;

@property (nonatomic, weak) UILabel *PlateTitleLab;

@property (nonatomic, weak) UILabel *PlateLab;

@property (nonatomic, weak) UILabel *DrivingYearTitleLab;

@property (nonatomic, weak) UILabel *DrivingYearLab;

@property (nonatomic, weak) UILabel *CarYearTitleLab;

@property (nonatomic, weak) UILabel *CarYearLab;

@property (nonatomic, weak) UIImageView *statusIconImg;

@end

@implementation RH_InsListCell

+ (instancetype)RH_InsListCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_InsListCell";
    
    RH_InsListCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_InsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *cotitle = [[UILabel alloc] init];
        
        self.CoTitleLab = cotitle;
        
        cotitle.textColor = Ins_TitleColor;
        
        cotitle.font = Ins_TitleFont;
        
        [self addSubview:cotitle];
        
        UILabel *co = [[UILabel alloc] init];
        
        self.CoLab = co;
        
        co.textColor = Ins_ContentColor;
        
        co.font = Ins_ContentFont;
        
        [self addSubview:co];
        
        UILabel *timetitle = [[UILabel alloc] init];
        
        self.TimeTitleLab = timetitle;
        
        timetitle.textColor = Ins_TitleColor;
        
        timetitle.font = Ins_TitleFont;
        
        [self addSubview:timetitle];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.TimeLab = time;
        
        time.textColor = Ins_ContentColor;
        
        time.font = Ins_ContentFont;
        
        [self addSubview:time];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.CountTitleLab = counttitle;
        
        counttitle.textColor = Ins_TitleColor;
        
        counttitle.font = Ins_TitleFont;
        
        [self addSubview:counttitle];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.CountLab = count;
        
        count.textColor = Ins_ContentColor;
        
        count.font = Ins_ContentFont;
        
        [self addSubview:count];
        
        UILabel *platetitle = [[UILabel alloc] init];
        
        self.PlateTitleLab = platetitle;
        
        platetitle.textColor = Ins_TitleColor;
        
        platetitle.font = Ins_TitleFont;
        
        [self addSubview:platetitle];
        
        UILabel *plate = [[UILabel alloc] init];
        
        self.PlateLab = plate;
        
        plate.textColor = Ins_ContentColor;
        
        plate.font = Ins_ContentFont;
        
        [self addSubview:plate];
        
        UILabel *drivingtitle = [[UILabel alloc] init];
        
        self.DrivingYearTitleLab = drivingtitle;
        
        drivingtitle.textColor = Ins_TitleColor;
        
        drivingtitle.font = Ins_TitleFont;
        
        [self addSubview:drivingtitle];
        
        UILabel *driving = [[UILabel alloc] init];
        
        self.DrivingYearLab = driving;
        
        driving.textColor = Ins_ContentColor;
        
        driving.font = Ins_ContentFont;
        
        [self addSubview:driving];
        
        UILabel *cartitle = [[UILabel alloc] init];
        
        self.CarYearTitleLab = cartitle;
        
        cartitle.textColor = Ins_TitleColor;
        
        cartitle.font = Ins_TitleFont;
        
        [self addSubview:cartitle];
        
        UILabel *car = [[UILabel alloc] init];
        
        self.CarYearLab = car;
        
        car.textColor = Ins_ContentColor;
        
        car.font = Ins_ContentFont;
        
        [self addSubview:car];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.statusIconImg = icon;
        
        [self addSubview:icon];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RH_InsListFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.CoTitleLab.frame = self.frameModel.COTitleF;
    
    self.CoLab.frame = self.frameModel.COF;
    
    self.TimeTitleLab.frame = self.frameModel.TimeTitleF;
    
    self.TimeLab.frame = self.frameModel.TimeF;
    
    self.CountTitleLab.frame = self.frameModel.CountTitleF;
    
    self.CountLab.frame = self.frameModel.CountF;
    
    self.PlateTitleLab.frame = self.frameModel.PlateTitleF;
    
    self.PlateLab.frame = self.frameModel.PlateF;
    
    self.DrivingYearTitleLab.frame = self.frameModel.DrivingYearTitleF;
    
    self.DrivingYearLab.frame = self.frameModel.DrivingYearF;
    
    self.CarYearTitleLab.frame = self.frameModel.CarYearTitleF;
    
    self.CarYearLab.frame = self.frameModel.CarYearF;
    
    self.statusIconImg.frame = self.frameModel.StatusIconF;
    
}

- (void)setContent {

    RH_InsListModel *model = self.frameModel.listModel;
    
    self.CoTitleLab.text = @"保险公司";
    
    self.CoLab.text = model.InsuranceCompany;
    
    self.TimeTitleLab.text = @"投保时间";
    
    self.TimeLab.text = model.InsuredTime;
    
    self.CountTitleLab.text = @"投保金额";
    
    self.CountLab.text = model.InsuredAmount;
    
    self.PlateTitleLab.text = @"车牌";
    
    self.PlateLab.text = model.CarBrand;
    
    self.DrivingYearTitleLab.text = @"驾龄";
    
    self.DrivingYearLab.text = model.DrivingAge;
    
    self.CarYearTitleLab.text = @"车龄";
    
    self.CarYearLab.text = model.CarAge;
    
    if ([model.HandleState isEqualToString:@"办理中"]) {
        
        self.statusIconImg.image = [UIImage imageNamed:@"Insurance_办理中.png"];
        
    }else if ([model.HandleState isEqualToString:@"办理成功"]) {

        self.statusIconImg.image = [UIImage imageNamed:@"Insurance_办理成功.png"];
        
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
