//
//  Add_ContactCell.m
//  HuiHui
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Add_ContactCell.h"
#import "Add_ContactModel.h"
#import "Add_ContactFrame.h"

#define NameFont [UIFont systemFontOfSize:19]
#define NickFont [UIFont systemFontOfSize:15]
#define PhoneFont [UIFont systemFontOfSize:16]
#define NameColor [UIColor colorWithRed:24/255.f green:24/255.f blue:24/255.f alpha:1.0]
#define PhoneColor [UIColor colorWithRed:123/255.f green:123/255.f blue:123/255.f alpha:1.0]
#define NickColor [UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]
#define LineColor [UIColor colorWithRed:243/255.f green:243/255.f blue:243/255.f alpha:1.0]
#define BoderColor [UIColor colorWithRed:201/255.f green:206/255.f blue:209/255.f alpha:1.0]
#define NOColor [UIColor colorWithRed:10/255.f green:10/255.f blue:10/255.f alpha:1.0]
#define YESColor [UIColor colorWithRed:164/255.f green:164/255.f blue:164/255.f alpha:1.0]

@interface Add_ContactCell ()

@property (nonatomic, weak) UIImageView *iconImageview;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UILabel *phoneLab;

@property (nonatomic, weak) UILabel *nickLab;

@property (nonatomic, weak) UIButton *addBtn;

@property (nonatomic, weak) UILabel *lineLab;

@end

@implementation Add_ContactCell

+ (instancetype)Add_ContactCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Add_ContactCell";
    
    Add_ContactCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Add_ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImageview = icon;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.textColor = NameColor;
        
        name.font = NameFont;
        
        [self addSubview:name];
        
        UILabel *nick = [[UILabel alloc] init];
        
        self.nickLab = nick;
        
        nick.textColor = NickColor;
        
        nick.font = NickFont;
        
        [self addSubview:nick];
        
        UILabel *phone = [[UILabel alloc] init];
        
        self.phoneLab = phone;
        
        phone.textColor = PhoneColor;
        
        phone.font = PhoneFont;
        
        [self addSubview:phone];
        
        UIButton *add = [[UIButton alloc] init];
        
        self.addBtn = add;
        
        [self addSubview:add];
        
        UILabel *line = [[UILabel alloc] init];
        
        self.lineLab = line;
        
        line.backgroundColor = LineColor;
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Add_ContactFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImageview.frame = self.frameModel.iconF;
    
    self.iconImageview.layer.masksToBounds = YES;
    
    self.iconImageview.layer.cornerRadius = self.frameModel.iconF.size.width * 0.5;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.nickLab.frame = self.frameModel.nickF;
    
    self.phoneLab.frame = self.frameModel.phoneF;
    
    self.addBtn.frame = self.frameModel.addF;
    
    self.lineLab.frame = self.frameModel.lineF;
    
}

- (void)setContent {
    
    Add_ContactModel *model = self.frameModel.add_contact;

    self.iconImageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",model.iconUrl]];
    
    self.nameLab.text = [NSString stringWithFormat:@"%@",model.name];
    
    NSString *str = [NSString stringWithFormat:@"%@",model.nick];
    
    if (![str isEqualToString:@""]) {
        
        self.nickLab.text = [NSString stringWithFormat:@"(%@)",str];
        
    }
    
    self.phoneLab.text = [NSString stringWithFormat:@"电话:%@",model.phone];
    
    if (model.isFriend) {
        
        [self.addBtn setTitle:@"已添加" forState:0];
        
        [self.addBtn setTitleColor:YESColor forState:0];
        
        self.addBtn.userInteractionEnabled = NO;
        
    }else {
    
        [self.addBtn setTitle:@"添加" forState:0];
        
        [self.addBtn setTitleColor:NOColor forState:0];
        
        self.addBtn.userInteractionEnabled = YES;
        
        self.addBtn.layer.masksToBounds = YES;
        
        self.addBtn.layer.borderColor = BoderColor.CGColor;
        
        self.addBtn.layer.borderWidth = 1;
        
        self.addBtn.layer.cornerRadius = 3;
        
    }
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

}

@end
