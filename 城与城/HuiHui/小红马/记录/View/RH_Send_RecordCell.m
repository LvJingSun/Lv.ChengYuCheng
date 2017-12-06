//
//  RH_Send_RecordCell.m
//  HuiHui
//
//  Created by mac on 2017/8/4.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_Send_RecordCell.h"
#import "RedHorseHeader.h"
#import "RH_Send_RecordModel.h"
#import "RH_Send_RecordFrame.h"

@interface RH_Send_RecordCell ()

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *productLab;

@property (nonatomic, weak) UILabel *timeLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation RH_Send_RecordCell

+ (instancetype)RH_Send_RecordCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_Send_RecordCell";
    
    RH_Send_RecordCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_Send_RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor blackColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.font = [UIFont systemFontOfSize:18];
        
        count.textColor = [UIColor colorWithRed:206/255. green:0/255. blue:0/255. alpha:1.];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *product = [[UILabel alloc] init];
        
        self.productLab = product;
        
        product.font = [UIFont systemFontOfSize:15];
        
        product.textColor = [UIColor colorWithRed:61/255. green:60/255. blue:60/255. alpha:1.];
        
        [self addSubview:product];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timeLab = time;
        
        time.font = [UIFont systemFontOfSize:15];
        
        time.textColor = [UIColor colorWithRed:112/255. green:110/255. blue:110/255. alpha:1.];
        
        time.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:time];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:241/255. green:241/255. blue:241/255. alpha:1.];
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RH_Send_RecordFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.productLab.frame = self.frameModel.productF;
    
    self.timeLab.frame = self.frameModel.timeF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    RH_Send_RecordModel *model = self.frameModel.listModel;
    
    self.nameLab.text = model.Memberid;
    
    self.countLab.text = model.Num;
    
    self.productLab.text = model.Goodsname;
    
    self.timeLab.text = model.CreateDate;
    
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
