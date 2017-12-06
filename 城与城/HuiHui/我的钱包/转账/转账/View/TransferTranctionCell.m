//
//  TransferTranctionCell.m
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "TransferTranctionCell.h"
#import "TransferTransactionModel.h"
#import "TransferTransactionFrame.h"
#import "RedHorseHeader.h"

@interface TransferTranctionCell ()

@property (nonatomic, weak) UIImageView *iconImg;

@property (nonatomic, weak) UILabel *nameLab;

@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) UILabel *countTitleLab;

@property (nonatomic, weak) UITextField *countField;

@property (nonatomic, weak) UIButton *sureBtn;

@end

@implementation TransferTranctionCell

+ (instancetype)TransferTranctionCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"TransferTranctionCell";
    
    TransferTranctionCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[TransferTranctionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = RH_ViewBGColor;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *icon = [[UIImageView alloc] init];
        
        self.iconImg = icon;
        
        icon.layer.masksToBounds = YES;
        
        [self addSubview:icon];
        
        UILabel *name = [[UILabel alloc] init];
        
        self.nameLab = name;
        
        name.font = [UIFont systemFontOfSize:16];
        
        name.textColor = [UIColor colorWithRed:35/255. green:35/255. blue:35/255. alpha:1.];
        
        name.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:name];
        
        UIView *bgview = [[UIView alloc] init];
        
        self.bgView = bgview;
        
        bgview.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bgview];
        
        UILabel *counttitle = [[UILabel alloc] init];
        
        self.countTitleLab = counttitle;
        
        counttitle.font = [UIFont systemFontOfSize:15];
        
        counttitle.textColor = [UIColor colorWithRed:23/255. green:23/255. blue:23/255. alpha:1.];
        
        [bgview addSubview:counttitle];
        
        UITextField *count = [[UITextField alloc] init];
        
        self.countField = count;
        
        count.leftViewMode = UITextFieldViewModeAlways;
        
        count.keyboardType = UIKeyboardTypeDecimalPad;
        
        count.font = [UIFont systemFontOfSize:45];
        
        [count addTarget:self action:@selector(countChange:) forControlEvents:UIControlEventEditingChanged];
        
        [bgview addSubview:count];
        
        UIButton *surebtn = [[UIButton alloc] init];
        
        self.sureBtn = surebtn;
        
        surebtn.layer.masksToBounds = YES;
        
        [surebtn setBackgroundColor:[UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]];
        
        surebtn.layer.cornerRadius = 4;
        
        [surebtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:surebtn];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(TransferTransactionFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.iconImg.frame = self.frameModel.iconF;
    
    self.nameLab.frame = self.frameModel.nameF;
    
    self.bgView.frame = self.frameModel.bgF;
    
    self.countTitleLab.frame = self.frameModel.countTitleF;
    
    self.countField.frame = self.frameModel.countF;
    
    CGSize mileagerightsize = [self sizeWithText:@"¥" font:[UIFont systemFontOfSize:45] maxSize:CGSizeMake(0,self.frameModel.countF.size.height)];
    
    UILabel *mileagelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mileagerightsize.width + 20, self.frameModel.countF.size.height)];
    
    mileagelab.text = @"¥";
    
    mileagelab.font = [UIFont systemFontOfSize:45];
    
    self.countField.leftView = mileagelab;
    
    self.sureBtn.frame = self.frameModel.sureF;
    
}

- (void)setContent {

    TransferTransactionModel *model = self.frameModel.tranModel;
    
    self.iconImg.image = [UIImage imageNamed:model.toFriendImg];
    
    self.nameLab.text = model.toFriendName;

    self.countTitleLab.text = @"转账金额";
    
    if ([self isNULLString:model.count]) {
        
        self.countField.text = @"";
        
    }else {
    
        self.countField.text = model.count;
        
    }
    
    [self.sureBtn setTitle:@"确认" forState:0];
    
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];
    
}

//金额代理
- (void)countChange:(UITextField *)field {

    if ([self.delegate respondsToSelector:@selector(CountFieldChange:)]) {
        
        [self.delegate CountFieldChange:field];
        
    }
    
}

- (void)sureClick {

    if (self.sureBlock) {
        
        self.sureBlock();
        
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self hideKeyboard];
    
}

- (void)hideKeyboard {
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    
}

- (BOOL)isNULLString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
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
