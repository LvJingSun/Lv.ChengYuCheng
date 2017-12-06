//
//  RH_BottomShopCell.m
//  HuiHui
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "RH_BottomShopCell.h"
#import "RedHorseHeader.h"
#import "RH_BoModel.h"
#import "RH_BoFrame.h"

@interface RH_BottomShopCell ()

@property (nonatomic, weak) UILabel *titlelab;

@property (nonatomic, weak) UILabel *leftLine;

@property (nonatomic, weak) UILabel *rightLine;

@end

@implementation RH_BottomShopCell

+ (instancetype)RH_BottomShopCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"RH_BottomShopCell";
    
    RH_BottomShopCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[RH_BottomShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = RH_ViewBGColor;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titlelab = title;
        
        title.textColor = [UIColor darkGrayColor];
        
        title.font = [UIFont systemFontOfSize:12];
        
        title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:title];
        
        UILabel *leftlab = [[UILabel alloc] init];
        
        self.leftLine = leftlab;
        
        leftlab.backgroundColor = [UIColor darkGrayColor];
        
        [self addSubview:leftlab];
        
        UILabel *rightlab = [[UILabel alloc] init];
        
        self.rightLine = rightlab;
        
        rightlab.backgroundColor = [UIColor darkGrayColor];
        
        [self addSubview:rightlab];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(RH_BoFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.titlelab.frame = self.frameModel.titleF;
    
    self.leftLine.frame = self.frameModel.leftF;
    
    self.rightLine.frame = self.frameModel.rightF;
    
}

- (void)setContent {
    
    RH_BoModel *model = self.frameModel.bomodel;

    self.titlelab.text = [NSString stringWithFormat:@"%@",model.title];
    
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [text boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
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
