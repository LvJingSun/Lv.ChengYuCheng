//
//  RepairMaintainCell.m
//  HuiHui
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RepairMaintainCell.h"
#import "RepairMaintainModel.h"
#import "RepairMaintainFrame.h"
#import "RedHorseHeader.h"

@interface RepairMaintainCell ()

@property (nonatomic, weak) UIImageView *icon;

@property (nonatomic, weak) UIView *bgview;

@property (nonatomic, weak) UILabel *counttitle;

@property (nonatomic, weak) UILabel *count;

@property (nonatomic, weak) UILabel *statustitle;

@property (nonatomic, weak) UILabel *status;

@property (nonatomic, weak) UILabel *contenttitle;

@property (nonatomic, weak) UILabel *content;

@property (nonatomic, weak) UILabel *time;

@end

@implementation RepairMaintainCell

+ (instancetype)RepairMaintainCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RepairMaintainCell";
    
    RepairMaintainCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RepairMaintainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.icon = icon;
        
        [self addSubview:icon];
        
        UIView *bg = [[UIView alloc] init];
        
        self.bgview = bg;
        
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
        
        UILabel *contenttitle = [[UILabel alloc] init];
        
        self.contenttitle = contenttitle;
        
        contenttitle.textColor = Oil_TitleColor;
        
        contenttitle.font = Oil_TitleFont;
        
        [self addSubview:contenttitle];
        
        UILabel *content = [[UILabel alloc] init];
        
        self.content = content;
        
        content.textColor = Oil_ContentColor;
        
        content.font = Oil_ContentFont;
        
        [self addSubview:content];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.time = time;
        
        time.textColor = Oil_TimeColor;
        
        time.font = Oil_TimeFont;
        
        [self addSubview:time];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RepairMaintainFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.icon.frame = self.frameModel.imgF;
    
    self.bgview.frame = self.frameModel.bgviewF;
    
    self.counttitle.frame = self.frameModel.CountTitleF;
    
    self.count.frame = self.frameModel.countF;
    
    self.statustitle.frame = self.frameModel.StatusTitleF;
    
    self.status.frame = self.frameModel.statusF;
    
    self.contenttitle.frame = self.frameModel.ContentTitleF;
    
    self.content.frame = self.frameModel.contentF;
    
    self.time.frame = self.frameModel.timeF;
    
}

- (void)setContent {
    
    RepairMaintainModel *model = self.frameModel.repairModel;
    
    if ([model.type isEqualToString:@"1"]) {
        
        self.icon.image = [UIImage imageNamed:@"Repair.png"];
        
    }else if ([model.type isEqualToString:@"2"]) {
    
        self.icon.image = [UIImage imageNamed:@"Maintain.png"];
        
    }

    self.counttitle.text = @"金额：";
    
    self.count.text = [NSString stringWithFormat:@"%@元",model.count];
    
    self.statustitle.text = @"状态：";
    
    self.status.text = [NSString stringWithFormat:@"%@",model.status];
    
    self.contenttitle.text = @"服务内容：";
    
    self.content.text = [NSString stringWithFormat:@"%@",model.content];
    
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
