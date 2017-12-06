//
//  Car_DetailCell.m
//  HuiHui
//
//  Created by mac on 2017/6/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Car_DetailCell.h"
#import "RH_CarModel.h"
#import "Car_DetailFrame.h"
#import "Car_DetailCell.h"
#import "RedHorseHeader.h"

@interface Car_DetailCell ()

@property (nonatomic, weak) UIImageView *carImg;

@property (nonatomic, weak) UILabel *carModelLab;

@property (nonatomic, weak) UILabel *line1Lab;

@property (nonatomic, weak) UILabel *PlateTitleLab;

@property (nonatomic, weak) UILabel *PlateLab;

@property (nonatomic, weak) UILabel *plateLine;

@property (nonatomic, weak) UILabel *timeTitleLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *timeLine;

@property (nonatomic, weak) UILabel *moneyTitleLab;

@property (nonatomic, weak) UILabel *moneyLab;

@property (nonatomic, weak) UILabel *moneyLine;

@property (nonatomic, weak) UILabel *EngineNumberTitleLab;

@property (nonatomic, weak) UILabel *EngineNumberLab;

@property (nonatomic, weak) UILabel *EngineNumberLine;

@property (nonatomic, weak) UILabel *MileageTitleLab;

@property (nonatomic, weak) UILabel *MileageLab;

@property (nonatomic, weak) UILabel *MileageLine;

@property (nonatomic, weak) UILabel *InvoiceTitleLab;

@property (nonatomic, weak) UIImageView *invoiceImg;

@property (nonatomic, weak) UIImageView *statusimg;

@end

@implementation Car_DetailCell

+ (instancetype)Car_DetailCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Car_DetailCell";
    
    Car_DetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Car_DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *carimg = [[UIImageView alloc] init];
        
        self.carImg = carimg;
        
        [self addSubview:carimg];
        
        UILabel *carmodel = [[UILabel alloc] init];
        
        self.carModelLab = carmodel;
        
        carmodel.textColor = CarInfo_ModelColor;
        
        carmodel.font = CarInfo_ModelFont;
        
        [self addSubview:carmodel];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1Lab = line1;
        
        line1.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line1];
        
        UILabel *platetitle = [[UILabel alloc] init];
        
        self.PlateTitleLab = platetitle;
        
        platetitle.font = CarInfo_TitleFont;
        
        platetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:platetitle];
        
        UILabel *platelab = [[UILabel alloc] init];
        
        self.PlateLab = platelab;
        
        platelab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:platelab];
        
        UILabel *plateline = [[UILabel alloc] init];
        
        self.plateLine = plateline;
        
        plateline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:plateline];
        
        UILabel *timetitle = [[UILabel alloc] init];
        
        self.timeTitleLab = timetitle;
        
        timetitle.font = CarInfo_TitleFont;
        
        timetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:timetitle];
        
        UILabel *timelab = [[UILabel alloc] init];
        
        self.timeLab = timelab;
        
        timelab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:timelab];
        
        UILabel *timeline = [[UILabel alloc] init];
        
        self.timeLine = timeline;
        
        timeline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:timeline];
        
        UILabel *moneytitle = [[UILabel alloc] init];
        
        self.moneyTitleLab = moneytitle;
        
        moneytitle.font = CarInfo_TitleFont;
        
        moneytitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:moneytitle];

        UILabel *moneylab = [[UILabel alloc] init];
        
        self.moneyLab = moneylab;
        
        moneylab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:moneylab];
        
        UILabel *moneyline = [[UILabel alloc] init];
        
        self.moneyLine = moneyline;
        
        moneyline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:moneyline];
        
        UILabel *EngineNumbertitle = [[UILabel alloc] init];
        
        self.EngineNumberTitleLab = EngineNumbertitle;
        
        EngineNumbertitle.font = CarInfo_TitleFont;
        
        EngineNumbertitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:EngineNumbertitle];
        
        UILabel *enginenumberlab = [[UILabel alloc] init];
        
        self.EngineNumberLab = enginenumberlab;
        
        enginenumberlab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:enginenumberlab];
        
        UILabel *EngineNumberline = [[UILabel alloc] init];
        
        self.EngineNumberLine = EngineNumberline;
        
        EngineNumberline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:EngineNumberline];
        
        UILabel *Mileagetitle = [[UILabel alloc] init];
        
        self.MileageTitleLab = Mileagetitle;
        
        Mileagetitle.font = CarInfo_TitleFont;
        
        Mileagetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:Mileagetitle];
        
        UILabel *mileagelab = [[UILabel alloc] init];
        
        self.MileageLab = mileagelab;
        
        mileagelab.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:mileagelab];
        
        UILabel *Mileageline = [[UILabel alloc] init];
        
        self.MileageLine = Mileageline;
        
        Mileageline.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:Mileageline];
        
        UILabel *Invoicetitle = [[UILabel alloc] init];
        
        self.InvoiceTitleLab = Invoicetitle;
        
        Invoicetitle.font = CarInfo_TitleFont;
        
        Invoicetitle.textColor = CarInfo_TitleColor;
        
        [self addSubview:Invoicetitle];
        
        UIImageView *invoiceimg = [[UIImageView alloc] init];
        
        self.invoiceImg = invoiceimg;
        
        [self addSubview:invoiceimg];
        
        UIImageView *statusimg = [[UIImageView alloc] init];
        
        self.statusimg = statusimg;
        
        [self addSubview:statusimg];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Car_DetailFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.carImg.frame = self.frameModel.carImgF;
    
    self.carModelLab.frame = self.frameModel.carModelF;
    
    self.line1Lab.frame = self.frameModel.Line1F;
    
    self.PlateTitleLab.frame = self.frameModel.carPlateTitleF;
    
    self.PlateLab.frame = self.frameModel.carPlateF;
    
    self.plateLine.frame = self.frameModel.carPlateLineF;
    
    self.timeTitleLab.frame = self.frameModel.timeTitleF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.timeLine.frame = self.frameModel.timeLineF;
    
    self.moneyTitleLab.frame = self.frameModel.moneyTitleF;
    
    self.moneyLab.frame = self.frameModel.moneyF;
    
    self.moneyLine.frame = self.frameModel.moneyLineF;
    
    self.EngineNumberTitleLab.frame = self.frameModel.EngineNumberTitleF;
    
    self.EngineNumberLab.frame = self.frameModel.EngineNumberF;
    
    self.EngineNumberLine.frame = self.frameModel.EngineNumberLineF;
    
    self.MileageTitleLab.frame = self.frameModel.MileageTitleF;
    
    self.MileageLab.frame = self.frameModel.MileageF;
    
    self.MileageLine.frame = self.frameModel.MileageLineF;
    
    self.InvoiceTitleLab.frame = self.frameModel.InvoiceTitleF;
    
    self.invoiceImg.frame = self.frameModel.InvoiceImgF;
    
    self.statusimg.frame = self.frameModel.carStatusF;
    
}

- (void)setContent {

    RH_CarModel *model = self.frameModel.carModel;
    
    [self.carImg setImageWithURL:[NSURL URLWithString:model.carImg] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    self.carModelLab.text = [NSString stringWithFormat:@"%@",model.carModel];
    
    self.PlateTitleLab.text = @"车牌号码";
    
    self.PlateLab.text = [NSString stringWithFormat:@"%@",model.carPlate];
    
    self.timeTitleLab.text = @"购车时间";
    
    self.timeLab.text = [NSString stringWithFormat:@"%@",model.buyTime];
    
    self.moneyTitleLab.text = @"购车款";
    
    self.moneyLab.text = [NSString stringWithFormat:@"%@",model.buyMoney];
    
    self.EngineNumberTitleLab.text = @"发动机号";
    
    self.EngineNumberLab.text = [NSString stringWithFormat:@"%@",model.EngineNumber];
    
    self.MileageTitleLab.text = @"行驶里程";
    
    self.MileageLab.text = [NSString stringWithFormat:@"%@",model.Mileage];
    
    self.InvoiceTitleLab.text = @"购车发票";
    
    [self.invoiceImg setImageWithURL:[NSURL URLWithString:model.InvoiceImgUrl] placeholderImage:[UIImage imageNamed:@"RH_发票占位.png"]];
    
    if ([model.CarStatus isEqualToString:@"已拒绝"]) {
        
        self.statusimg.image = [UIImage imageNamed:@"RH_未通过.png"];
        
    }else if ([model.CarStatus isEqualToString:@"审核中"]) {
        
        self.statusimg.image = [UIImage imageNamed:@"RH_审核中.png"];
        
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
