//
//  Z_SearchCell.m
//  HuiHui
//
//  Created by mac on 2017/7/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import "Z_SearchCell.h"
#import "Z_SearchModel.h"
#import "Z_SearchFrame.h"
#import "RedHorseHeader.h"

@interface Z_SearchCell ()

@property (nonatomic, weak) UITextField *phoneField;

@property (nonatomic, weak) UILabel *titleLab;

@property (nonatomic, weak) UIButton *nextBtn;

@end

@implementation Z_SearchCell

+ (instancetype)Z_SearchCellWithTableview:(UITableView *)tableview {

    static NSString *cellID = @"Z_SearchCell";
    
    Z_SearchCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[Z_SearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RH_ViewBGColor;
        
        UITextField *field = [[UITextField alloc] init];
        
        self.phoneField = field;
        
        field.font = [UIFont systemFontOfSize:18];
        
        field.keyboardType = UIKeyboardTypePhonePad;
        
        [field addTarget:self action:@selector(phoneChange:) forControlEvents:UIControlEventEditingChanged];
        
        field.backgroundColor = [UIColor whiteColor];
        
        field.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:field];
        
        UILabel *title = [[UILabel alloc] init];
        
        self.titleLab = title;
        
        title.textColor = [UIColor colorWithRed:127/255. green:127/255. blue:127/255. alpha:1.];
        
        title.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:title];
        
        UIButton *next = [[UIButton alloc] init];
        
        self.nextBtn = next;
        
        next.layer.masksToBounds = YES;
        
        next.layer.cornerRadius = 4;
        
        [next setTitle:@"下一步" forState:0];
        
        [next setTitleColor:[UIColor colorWithRed:187/255. green:187/255. blue:187/255. alpha:1.] forState:0];
        
        [next setBackgroundColor:[UIColor colorWithRed:221/255. green:221/255. blue:221/255. alpha:1.]];
        
        [self addSubview:next];
        
    }
    
    return self;
    
}

-(void)setFrameModel:(Z_SearchFrame *)frameModel {

    _frameModel = frameModel;
    
    [self setRect];
    
    [self setContent];
    
}

- (void)setRect {

    self.phoneField.frame = self.frameModel.phoneF;
    
    CGSize mileagerightsize = [self sizeWithText:@"对方账户：" font:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(0,self.frameModel.phoneF.size.height)];
    
    UILabel *mileagelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mileagerightsize.width + ScreenWidth * 0.05, self.frameModel.phoneF.size.height)];
    
    mileagelab.text = @"对方账户：";
    
    mileagelab.textAlignment = NSTextAlignmentRight;
    
    mileagelab.font = [UIFont systemFontOfSize:18];
    
    self.phoneField.leftView = mileagelab;
    
    self.titleLab.frame = self.frameModel.titleF;
    
    self.nextBtn.frame = self.frameModel.nextF;
    
}

- (void)setContent {

    Z_SearchModel *model = self.frameModel.searchModel;
    
    self.titleLab.text = @"钱将实时转入对方账户，无法退款";
    
    if ([self isNULLString:model.searchPhone]) {
        
        self.phoneField.text = @"";
        
    }else {
    
        self.phoneField.text = model.searchPhone;
        
    }
    
    if ([model.isPhoneNumber isEqualToString:@"0"]) {
        
        [self.nextBtn setTitleColor:[UIColor colorWithRed:187/255. green:187/255. blue:187/255. alpha:1.] forState:0];
        
        [self.nextBtn setBackgroundColor:[UIColor colorWithRed:221/255. green:221/255. blue:221/255. alpha:1.]];
        
    }else if ([model.isPhoneNumber isEqualToString:@"1"]) {
    
        [self.nextBtn setTitleColor:[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1.] forState:0];
        
        [self.nextBtn setBackgroundColor:[UIColor colorWithRed:72/255.f green:162/255.f blue:245/255.f alpha:1.0]];
        
    }
    
}

//账户代理
- (void)phoneChange:(UITextField *)field {
    
    if ([self.delegate respondsToSelector:@selector(PhoneFieldChange:)]) {
        
        [self.delegate PhoneFieldChange:field];
        
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
