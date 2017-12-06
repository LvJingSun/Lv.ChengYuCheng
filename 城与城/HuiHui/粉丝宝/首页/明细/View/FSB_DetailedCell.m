//
//  FSB_DetailedCell.m
//  HuiHui
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_DetailedCell.h"
#import "LJConst.h"
#import "FSB_DetailedModel.h"
#import "FSB_DetailedFrame.h"
#import "LJ_Progress.h"

@interface FSB_DetailedCell ()

@property (nonatomic, weak) UILabel *sourceLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) LJ_Progress *progressView;

@property (nonatomic, weak) UILabel *totalLab;

@property (nonatomic, weak) UILabel *totalEDuLab;

@property (nonatomic, weak) UILabel *progressCountLab;

@property (nonatomic, weak) UILabel *fanliLab;

@property (nonatomic, weak) UILabel *daysLab;

@property (nonatomic, weak) UILabel *dateLab;

@property (nonatomic, weak) UILabel *goodLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *toplineLab;

@property (nonatomic, weak) UILabel *bottomlineLab;

@property (nonatomic, weak) UILabel *liyouLab;

@property (nonatomic, weak) UIButton *phoneBtn;

@end

@implementation FSB_DetailedCell

+ (instancetype)FSB_DetailedCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_DetailedCell";
    
    FSB_DetailedCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_DetailedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *source = [[UILabel alloc] init];
        
        self.sourceLab = source;
        
        source.textAlignment = NSTextAlignmentLeft;
        
        source.font = FSB_DetailedSourceFont;
        
        source.textColor = FSB_DetailedSourceCOLOR;
        
        [self addSubview:source];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.textAlignment = NSTextAlignmentRight;
        
        status.font = FSB_DetailedSourceFont;
        
        [self addSubview:status];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = FSB_DetailedBGCOLOR;
        
        [self addSubview:bg];
        
        LJ_Progress *progress = [[LJ_Progress alloc] init];
        
        self.progressView = progress;
        
        progress.layer.masksToBounds = YES;
        
        [self addSubview:progress];
        
        UILabel *total = [[UILabel alloc] init];
        
        self.totalLab = total;
        
        total.textColor = FSB_StyleCOLOR;
        
        total.font = FSB_DetailedCountFont;
        
        [self addSubview:total];
        
        UILabel *totaledu = [[UILabel alloc] init];
        
        self.totalEDuLab = totaledu;
        
        totaledu.textAlignment = NSTextAlignmentLeft;
        
        totaledu.textColor = FSB_DetailedTotalCountCOLOR;
        
        totaledu.font = FSB_DetailedCountFont;
        
        [self addSubview:totaledu];
        
        UILabel *progresscount = [[UILabel alloc] init];
        
        self.progressCountLab = progresscount;
        
        progresscount.textAlignment = NSTextAlignmentRight;
        
        progresscount.textColor = FSB_StyleCOLOR;
        
        progresscount.font = FSB_DetailedCountFont;
        
        [self addSubview:progresscount];
        
        UILabel *fanli = [[UILabel alloc] init];
        
        self.fanliLab = fanli;
        
        fanli.textAlignment = NSTextAlignmentLeft;
        
        fanli.textColor = FSB_DetailedFanliCOLOR;
        
        fanli.font = FSB_DetailedFanliFont;
        
        [self addSubview:fanli];
        
        UILabel *days = [[UILabel alloc] init];
        
        self.daysLab = days;
        
        days.textAlignment = NSTextAlignmentRight;
        
        days.textColor = FSB_DetailedFanliCOLOR;
        
        days.font = FSB_DetailedFanliFont;
        
        [self addSubview:days];
        
        UILabel *date = [[UILabel alloc] init];
        
        self.dateLab = date;
        
        date.textAlignment = NSTextAlignmentLeft;
        
        date.textColor = FSB_DetailedFanliCOLOR;
        
        date.font = FSB_DetailedFanliFont;
        
        [self addSubview:date];
        
        UILabel *good = [[UILabel alloc] init];
        
        self.goodLab = good;
        
        good.textAlignment = NSTextAlignmentRight;
        
        good.textColor = FSB_DetailedFanliCOLOR;
        
        good.font = FSB_DetailedFanliFont;
        
        [self addSubview:good];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
        UILabel *top = [[UILabel alloc] init];
        
        self.toplineLab = top;
        
        top.backgroundColor = FSB_DetailedLineCOLOR;
        
        [self addSubview:top];
        
        UILabel *bottom = [[UILabel alloc] init];
        
        self.bottomlineLab = bottom;
        
        bottom.backgroundColor = FSB_DetailedLineCOLOR;
        
        [self addSubview:bottom];
        
        UILabel *liyou = [[UILabel alloc] init];
        
        self.liyouLab = liyou;
        
        liyou.textColor = [UIColor colorWithRed:255/255.f green:53/255.f blue:53/255.f alpha:1.0];
        
        liyou.font = FSB_DetailedFanliFont;
        
        [self addSubview:liyou];
        
        UIButton *phone = [[UIButton alloc] init];
        
        self.phoneBtn = phone;
        
        phone.layer.masksToBounds = YES;
        
        phone.layer.cornerRadius = 3;
        
        phone.layer.borderColor = [UIColor colorWithRed:255/255.f green:53/255.f blue:53/255.f alpha:1.0].CGColor;
        
        phone.layer.borderWidth = 0.7;
        
        [phone setTitleColor:[UIColor colorWithRed:255/255.f green:53/255.f blue:53/255.f alpha:1.0] forState:0];
        
        phone.titleLabel.font = FSB_DetailedFanliFont;
        
        [self addSubview:phone];
        
    }
    
    return self;

}

-(void)setFrameModel:(FSB_DetailedFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.sourceLab.frame = self.frameModel.SourceF;
    
    self.statusLab.frame = self.frameModel.StatusF;
    
    self.bgView.frame = self.frameModel.bgviewF;
    
    self.progressView.frame = self.frameModel.progressF;
    
    self.progressView.layer.cornerRadius = self.frameModel.progressF.size.height * 0.5;
    
    self.progressView.layer.borderColor = FSB_DetailedProgressCOLOR.CGColor;
    
    self.progressView.layer.borderWidth = 1;
    
    self.totalLab.frame = self.frameModel.TotalF;
    
    self.totalEDuLab.frame = self.frameModel.totaleduF;
    
    self.progressCountLab.frame = self.frameModel.progressCountF;
    
    self.fanliLab.frame = self.frameModel.FanliIDF;
    
    self.daysLab.frame = self.frameModel.DaysF;
    
    self.dateLab.frame = self.frameModel.dateF;
    
    self.goodLab.frame = self.frameModel.goodF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.toplineLab.frame = self.frameModel.topF;
    
    self.bottomlineLab.frame = self.frameModel.bottomF;
    
    if ([self.frameModel.detailedModel.Status isEqualToString:@"2"]) {
    
        self.liyouLab.frame = self.frameModel.liyouF;
        
        self.phoneBtn.frame = self.frameModel.phoneF;
        
    }
    
}

- (void)setContent {

    FSB_DetailedModel *model = self.frameModel.detailedModel;
    
    self.sourceLab.text = [NSString stringWithFormat:@"%@",model.Source];
    
    if ([model.Status isEqualToString:@"1"]) {
        
        self.statusLab.text = @"进行中";
        
        self.statusLab.textColor = FSB_StyleCOLOR;
        
    }else if ([model.Status isEqualToString:@"4"]) {
        
        self.statusLab.text = @"已领完";
    
        self.statusLab.textColor = FSB_DetailedYiWanChengCOLOR;
        
    }else if ([model.Status isEqualToString:@"2"]) {
        
        self.statusLab.text = @"已暂停";
    
        self.statusLab.textColor = FSB_DetailedDongJieCOLOR;
        
        self.liyouLab.text = [NSString stringWithFormat:@"%@",model.liyou];
        
        [self.phoneBtn setTitle:@"申诉" forState:0];
        
        [self.phoneBtn addTarget:self action:@selector(PhoneClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([model.Status isEqualToString:@"3"]) {
        
        self.statusLab.text = @"已撤销";
        
        self.statusLab.textColor = FSB_DetailedDongJieCOLOR;
        
    }
    
    [self.progressView setProgress:[model.progress floatValue]];
    
    self.totalLab.text = [NSString stringWithFormat:@"%@",model.Total];
    
    self.totalEDuLab.text = [NSString stringWithFormat:@"/%@元",model.totaledu];
    
    self.progressCountLab.text = [NSString stringWithFormat:@"%.2f%%",[model.progress floatValue] * 100];
    
    self.fanliLab.text = [NSString stringWithFormat:@"商品名:%@",model.goodname];
    
    self.daysLab.text = [NSString stringWithFormat:@"已领取:%@份",model.Days];
    
    self.dateLab.text = [NSString stringWithFormat:@"返利号:%@",model.FanliID];
    
    self.goodLab.text = [NSString stringWithFormat:@"日期:%@",model.StartDate];
    
}

- (void)PhoneClick {

    if (self.phoneBlock) {
        
        self.phoneBlock();
        
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
