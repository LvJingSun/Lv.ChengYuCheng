//
//  RH_CarBrandCell.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_CarBrandCell.h"
#import "RH_CarBrandModel.h"
#import "RH_CarBrandFrame.h"
#import "RedHorseHeader.h"

@interface RH_CarBrandCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *title;

@property (nonatomic, weak) UILabel *line;

@end

@implementation RH_CarBrandCell

+ (instancetype)RH_CarBrandCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_CarBrandCell";
    
    RH_CarBrandCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_CarBrandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        [self addSubview:icon];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.title = title;
        
        [self addSubview:title];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.line = line;
        
        line.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RH_CarBrandFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.title.frame = self.frameModel.titleF;
    
    self.line.frame = self.frameModel.lineF;
    
}

- (void)setContent {

    RH_CarBrandModel *model = self.frameModel.brandmodel;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.ImageSrc] placeholderImage:[UIImage imageNamed:@"RH_CarPL.png"]];
    
    self.title.text = model.Name;
    
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
