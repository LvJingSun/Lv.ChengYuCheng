//
//  RH_ChildCarCell.m
//  HuiHui
//
//  Created by mac on 2017/6/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_ChildCarCell.h"
#import "RH_CarBrandModel.h"
#import "RH_ChildCarFrame.h"
#import "RedHorseHeader.h"

@interface RH_ChildCarCell ()

@property (nonatomic, weak) UILabel *title;

@property (nonatomic, weak) UILabel *line;

@end

@implementation RH_ChildCarCell

+ (instancetype)RH_ChildCarCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_ChildCarCell";
    
    RH_ChildCarCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_ChildCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
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

-(void)setFrameModel:(RH_ChildCarFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.title.frame = self.frameModel.titleF;
    
    self.line.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    RH_CarBrandModel *model = self.frameModel.brandmodel;

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
