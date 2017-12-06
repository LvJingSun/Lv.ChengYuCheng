//
//  FSB_TranDetailCell.m
//  HuiHui
//
//  Created by mac on 2017/9/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "FSB_TranDetailCell.h"
#import "FSB_TranDetailFrame.h"
#import "FSB_TranModel.h"
#import "RedHorseHeader.h"

@interface FSB_TranDetailCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *statusLab;

@property (nonatomic, weak) UILabel *CostTitleLab;

@property (nonatomic, weak) UILabel *CostLab;

@property (nonatomic, weak) UILabel *typeTitleLab;

@property (nonatomic, weak) UILabel *typeLab;

@property (nonatomic, weak) UILabel *goodTitleLab;

@property (nonatomic, weak) UILabel *goodLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) UILabel *timeTitleLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *NoTitleLab;

@property (nonatomic, weak) UILabel *NoLab;

@end

@implementation FSB_TranDetailCell

+ (instancetype)FSB_TranDetailCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"FSB_TranDetailCell";
    
    FSB_TranDetailCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[FSB_TranDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        
        name.textColor = [UIColor darkTextColor];
        
        name.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:name];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor blackColor];
        
        count.font = [UIFont systemFontOfSize:50];
        
        count.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:count];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.statusLab = status;
        
        status.textColor = [UIColor colorWithRed:152/255. green:152/255. blue:152/255. alpha:1.];
        
        status.font = [UIFont systemFontOfSize:15];
        
        status.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:status];
        
        UILabel *costtitle = [[UILabel alloc] init];
        
        self.CostTitleLab = costtitle;
        
        costtitle.textColor = [UIColor colorWithRed:116/255. green:116/255. blue:116/255. alpha:1.];
        
        costtitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:costtitle];
        
        UILabel *cost = [[UILabel alloc] init];
        
        self.CostLab = cost;
        
        cost.textAlignment = NSTextAlignmentRight;
        
        cost.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        cost.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:cost];
        
        UILabel *typetitle = [[UILabel alloc] init];
        
        self.typeTitleLab = typetitle;
        
        typetitle.textColor = [UIColor colorWithRed:116/255. green:116/255. blue:116/255. alpha:1.];
        
        typetitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:typetitle];
        
        UILabel *type = [[UILabel alloc] init];
        
        self.typeLab = type;
        
        type.textAlignment = NSTextAlignmentRight;
        
        type.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        type.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:type];
        
        UILabel *desctitle = [[UILabel alloc] init];
        
        self.goodTitleLab = desctitle;
        
        desctitle.textColor = [UIColor colorWithRed:116/255. green:116/255. blue:116/255. alpha:1.];
        
        desctitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:desctitle];
        
        UILabel *desc = [[UILabel alloc] init];
        
        self.goodLab = desc;
        
        desc.textAlignment = NSTextAlignmentRight;
        
        desc.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        desc.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:desc];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1.];
        
        [self addSubview:line];
        
        UILabel *timetitle = [[UILabel alloc] init];
        
        self.timeTitleLab = timetitle;
        
        timetitle.textColor = [UIColor colorWithRed:116/255. green:116/255. blue:116/255. alpha:1.];
        
        timetitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:timetitle];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.textAlignment = NSTextAlignmentRight;
        
        time.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        time.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:time];
        
        UILabel *Notitle = [[UILabel alloc] init];
        
        self.NoTitleLab = Notitle;
        
        Notitle.textColor = [UIColor colorWithRed:116/255. green:116/255. blue:116/255. alpha:1.];
        
        Notitle.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:Notitle];
        
        UILabel *No = [[UILabel alloc] init];
        
        self.NoLab = No;
        
        No.textAlignment = NSTextAlignmentRight;
        
        No.textColor = [UIColor colorWithRed:20/255. green:20/255. blue:20/255. alpha:1.];
        
        No.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:No];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(FSB_TranDetailFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.statusLab.frame = self.frameModel.statusF;
    
    self.CostTitleLab.frame = self.frameModel.feiyongTitleF;
    
    self.CostLab.frame = self.frameModel.feiyongF;
    
    self.typeTitleLab.frame = self.frameModel.typeTitleF;
    
    self.typeLab.frame = self.frameModel.typeF;
    
    self.goodTitleLab.frame = self.frameModel.descTitleF;
    
    self.goodLab.frame = self.frameModel.descF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.timeTitleLab.frame = self.frameModel.dateTitleF;
    
    self.timeLab.frame = self.frameModel.dateF;
    
    self.NoTitleLab.frame = self.frameModel.NoTitleF;
    
    self.NoLab.frame = self.frameModel.NoF;
    
}

- (void)setContent {

    FSB_TranModel *model = self.frameModel.tranmodel;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameLab.text = model.name;
    
    if ([model.TradingOperations isEqualToString:@"Income"]) {
        
        self.countLab.text = [NSString stringWithFormat:@"+%.2f",[model.count floatValue]];
        
    }else if ([model.TradingOperations isEqualToString:@"Expenditure"]) {
        
        self.countLab.text = [NSString stringWithFormat:@"-%.2f",[model.count floatValue]];
        
    }
    
    if ([model.status isEqualToString:@"Pending"] || [model.status isEqualToString:@"WAProcessing"]) {
        
        self.statusLab.text = @"确认中";
        
    }else if ([model.status isEqualToString:@"HasCompleted"]) {
        
        self.statusLab.text = @"交易成功";
        
    }else if ([model.status isEqualToString:@"HasRefused"] || [model.status isEqualToString:@"Unusual"]) {
        
        self.statusLab.text = @"交易失败";
        
    }
    
    self.CostTitleLab.text = @"交易费用";
    
    self.CostLab.text = model.CostDesc;
    
    self.typeTitleLab.text = @"交易方式";
    
    self.typeLab.text = model.TranType;
    
    self.goodTitleLab.text = @"商品说明";
    
    self.goodLab.text = model.GoodsDesc;
    
    self.timeTitleLab.text = @"交易时间";
    
    self.timeLab.text = model.CreateTime;
    
    self.NoTitleLab.text = @"交易单号";
    
    self.NoLab.text = model.OrderNo;
    
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
