//
//  OilSubsidyCell.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "OilSubsidyCell.h"
#import "OilSubsidyModel.h"
#import "OilSubsidyFrame.h"
#import "RedHorseHeader.h"

@interface OilSubsidyCell ()

@property (nonatomic, weak) UIImageView *img;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *counttitle;

@property (nonatomic, weak) UILabel *count;

@property (nonatomic, weak) UILabel *statustitle;

@property (nonatomic, weak) UILabel *status;

@property (nonatomic, weak) UILabel *time;

@end

@implementation OilSubsidyCell

+ (instancetype)OilSubsidyCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"OilSubsidyCell";
    
    OilSubsidyCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[OilSubsidyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UIImageView *img = [[UIImageView alloc] init];
        
        self.img = img;
        
        [self addSubview:img];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgView = bg;
        
        bg.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bg];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.counttitle = counttitle;
        
        counttitle.textColor = Oil_TitleColor;
        
        counttitle.font = Oil_TitleFont;
        
        [self addSubview:counttitle];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.count = count;
        
        count.textColor = Oil_ContentColor;
        
        count.font = Oil_ContentFont;
        
        [self addSubview:count];
        
        UILabel *statustitle = [[UILabel alloc] init];
        
        self.statustitle = statustitle;
        
        statustitle.textColor = Oil_TitleColor;
        
        statustitle.font = Oil_TitleFont;
        
        [self addSubview:statustitle];
        
        UILabel *status = [[UILabel alloc] init];
        
        self.status = status;
        
        status.textColor = Oil_ContentColor;
        
        status.font = Oil_ContentFont;
        
        [self addSubview:status];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.time = time;
        
        time.textColor = Oil_TimeColor;
        
        time.font = Oil_TimeFont;
        
        [self addSubview:time];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(OilSubsidyFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.img.frame = self.frameModel.imgF;
    
    self.bgView.frame = self.frameModel.bgviewF;
    
    self.counttitle.frame = self.frameModel.CountTitleF;
    
    self.count.frame = self.frameModel.countF;
    
    self.statustitle.frame = self.frameModel.StatusTitleF;
    
    self.status.frame = self.frameModel.statusF;
    
    self.time.frame = self.frameModel.timeF;
    
}

- (void)setContent {
    
    OilSubsidyModel *model = self.frameModel.subsidyModel;

    self.img.image = [UIImage imageNamed:@"Oil_Line.png"];
    
    self.counttitle.text = @"金额：";
    
    self.count.text = [NSString stringWithFormat:@"%@元",model.count];
    
    self.statustitle.text = @"状态：";
    
    self.status.text = [NSString stringWithFormat:@"%@",model.status];
    
    self.time.text = [NSString stringWithFormat:@"%@",model.time];
    
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
