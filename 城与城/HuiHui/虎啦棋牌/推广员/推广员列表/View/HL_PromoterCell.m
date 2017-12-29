//
//  HL_PromoterCell.m
//  HuiHui
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "HL_PromoterCell.h"
#import "HL_PromoterModel.h"
#import "HL_PromoterFrame.h"
#import "LJConst.h"

@interface HL_PromoterCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *delegateLab;

@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation HL_PromoterCell

+ (instancetype)HL_PromoterCellWithTableview:(UITableView *)tableview {
    
    static NSString *cellID = @"HL_PromoterCell";
    
    HL_PromoterCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[HL_PromoterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.backgroundColor = [UIColor lightGrayColor];
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = [UIColor darkTextColor];
        
        name.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:name];
        
        UILabel *delegate = [[UILabel alloc] init];
        
        self.delegateLab = delegate;
        
        delegate.textColor = [UIColor orangeColor];
        
        delegate.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:delegate];
        
        UILabel *count = [[UILabel alloc] init];
        
        self.countLab = count;
        
        count.textColor = [UIColor darkTextColor];
        
        count.font = [UIFont systemFontOfSize:15];
        
        count.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:count];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = FSB_ViewBGCOLOR;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(HL_PromoterFrame *)frameModel {
    
    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {
    
    self.iconImg.frame = self.frameModel.iconF;
    
    self.iconImg.layer.masksToBounds = YES;
    
    self.iconImg.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.delegateLab.frame = self.frameModel.delegateF;
    
    self.countLab.frame = self.frameModel.countF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    HL_PromoterModel *model = self.frameModel.promoterModel;
    
    [self.iconImg setImageWithURL:[NSURL URLWithString:model.icon]];
    
    self.nameLab.text = model.name;
    
    self.delegateLab.text = model.delegate;
    
    self.countLab.text = model.count;
    
}

//- (void)layoutSubviews {
//    
//    for (UIView *subView in self.subviews) {
//        
//        if([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
//            
//            // 拿到subView之后再获取子控件
//            
//            // 因为上面删除按钮是第一个加的所以下标是0
//            UIView *deleteView = subView.subviews[0];
//            //改背景颜色
//            deleteView.backgroundColor = [UIColor redColor];
//            
//            UIView *changeView = subView.subviews[1];
//            
//            changeView.backgroundColor = FSB_StyleCOLOR;
//            
//        }
//    }
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
