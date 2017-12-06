//
//  MyWallet_Cell.m
//  HuiHui
//
//  Created by mac on 2017/6/26.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "MyWallet_Cell.h"
#import "RedHorseHeader.h"
#import "New_WalletModel.h"
#import "New_WalletFrame.h"

@interface MyWallet_Cell ()

@property (nonatomic, weak) UIImageView *iconImag;

@property (nonatomic, weak) UILabel *titleLab;

//@property (nonatomic, weak) UILabel *countLab;

@property (nonatomic, weak) UIImageView *rightImg;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation MyWallet_Cell

+ (instancetype)MyWallet_CellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"MyWallet_Cell";
    
    MyWallet_Cell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[MyWallet_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImag = icon;
        
        [self addSubview:icon];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.font = [UIFont systemFontOfSize:18];
        
        title.textColor = [UIColor colorWithRed:21/255. green:21/255. blue:21/255. alpha:1];
        
        [self addSubview:title];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = CarInfo_LineColor;
        
        [self addSubview:line];
        
        UIImageView *right = [[UIImageView alloc] init];
        
        self.rightImg = right;
        
        [self addSubview:right];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(New_WalletFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setContent {

    New_WalletModel *model = self.frameModel.walletmodel;
    
    self.iconImag.image = [UIImage imageNamed:model.icon];
    
    self.titleLab.text = model.title;
    
    self.rightImg.image = [UIImage imageNamed:@"NearBy_More.png"];
    
}

- (void)setRect {

    self.iconImag.frame = self.frameModel.iconF;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.rightImg.frame = self.frameModel.rightF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
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
