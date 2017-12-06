//
//  GoldBrokenLineCell.m
//  HuiHui
//
//  Created by mac on 2017/9/11.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "GoldBrokenLineCell.h"
#import "GoldBrokenLineModel.h"
#import "GoldBrokenLineFrame.h"
#import "RedHorseHeader.h"
#import "F_BrokenLineView.h"

@interface GoldBrokenLineCell ()

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UILabel *lineLab;

@property (nonatomic, weak) F_BrokenLineView *brokenLineView;

@end

@implementation GoldBrokenLineCell

+ (instancetype)GoldBrokenLineCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"GoldBrokenLineCell";
    
    GoldBrokenLineCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[GoldBrokenLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textAlignment = NSTextAlignmentCenter;
        
        title.font = [UIFont systemFontOfSize:17];
        
        title.textColor = [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0];
        
        [self addSubview:title];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1.];
        
        [self addSubview:line];
        
        F_BrokenLineView *brokenview = [[F_BrokenLineView alloc] init];
        
        self.brokenLineView = brokenview;
        
        [self addSubview:brokenview];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(GoldBrokenLineFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.titleLab.frame = self.frameModel.titleF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
    self.brokenLineView.frame = self.frameModel.brokenF;
    
}

- (void)setContent {
    
    GoldBrokenLineModel *model = self.frameModel.brokenModel;

    self.titleLab.text = @"近日金价走势";
    
    self.brokenLineView.xArr = model.keyArr;
    
    self.brokenLineView.data1Arr = model.valueArr;
    
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
