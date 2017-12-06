//
//  Life_Cell.m
//  HuiHui
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Life_Cell.h"
#import "RedHorseHeader.h"
#import "Life_CellModel.h"
#import "Life_CellFrame.h"

@interface Life_Cell ()

@property (nonatomic, weak) UIImageView *image1view;

@property (nonatomic, weak) UILabel *title1lab;

@property (nonatomic, weak) UILabel *timelab;

@property (nonatomic, weak) UIView *bg1view;

@property (nonatomic, weak) UILabel *line1lab;

@end

@implementation Life_Cell

+ (instancetype)Life_CellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Life_Cell";
    
    Life_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Life_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *img1 = [[UIImageView alloc] init];
        
        self.image1view = img1;
        
        [self addSubview:img1];
        
        UIView *bg1 = [[UIView alloc] init];
        
        self.bg1view = bg1;
        
        bg1.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bg1];
        
        UILabel *title1 = [[UILabel alloc] init];
        
        self.title1lab = title1;
        
        title1.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:title1];
        
        UILabel *time = [[UILabel alloc] init];
        
        self.timelab = time;
        
        time.font = [UIFont systemFontOfSize:14];
        
        time.textColor = RH_NAVTextColor;
        
        time.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:time];
        
        UILabel *line1 = [[UILabel alloc] init];
        
        self.line1lab = line1;
        
        line1.backgroundColor = RH_ViewBGColor;
        
        [self addSubview:line1];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Life_CellFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.image1view.frame = self.frameModel.image1F;
    
    self.title1lab.frame = self.frameModel.title1F;
    
    self.bg1view.frame = self.frameModel.titleBGF;
    
    self.line1lab.frame = self.frameModel.lineF;
    
    self.timelab.frame = self.frameModel.timeF;
    
}

- (void)setContent {

    Life_CellModel *cellModel = self.frameModel.cellModel;
    
    [self.image1view setImageWithURL:[NSURL URLWithString:cellModel.imageName] placeholderImage:[UIImage imageNamed:@"生活占位图.png"]];
    
    self.title1lab.text = cellModel.titleName;
    
    self.timelab.text = cellModel.RemainingDay;
    
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
