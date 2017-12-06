//
//  PartyDetailCell.m
//  HuiHui
//
//  Created by mac on 14-10-21.
//  Copyright (c) 2014年 MaxLinksTec. All rights reserved.
//

#import "PartyDetailCell.h"

#import "MJPhoto.h"

#import "MJPhotoBrowser.h"

#import "BaseViewController.h"

#import "NSString+CXAHyperlinkParser.h"


//#define isIOS5 ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0 ? YES : NO)


@implementation PartyDetailCell

@synthesize m_imageList;

- (void)awakeFromNib
{
    // Initialization code
    
    m_imageList = [[NSMutableArray alloc]initWithCapacity:0];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetail:(NSString *)detail withPhoto:(NSMutableArray *)array withAddress:(NSString *)address{
    
    // 设置view的边框
    self.m_view.layer.borderWidth = 1.0;
    self.m_view.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;

    
    [self.m_imageList addObjectsFromArray:array];
    
    self.m_detailLabel.text = [NSString stringWithFormat:@"%@",detail];
    
    
    // 赋值
    CGSize size = [self.m_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_detailLabel.frame = CGRectMake(self.m_detailLabel.frame.origin.x, self.m_detailLabel.frame.origin.y, self.m_detailLabel.frame.size.width, size.height);
    
    
    self.m_addressLabel.text = [NSString stringWithFormat:@"%@",address];
    
    // 判断没有图片的情况下
    if ( array.count == 0 ) {
        
        self.m_photoView.hidden = YES;
        
        // 判断没有地理位置的情况下
        if ( address.length != 0 ) {
            
            self.m_addressView.hidden = NO;
            
            // 计算view的坐标
            self.m_addressView.frame = CGRectMake(self.m_addressView.frame.origin.x, self.m_detailLabel.frame.size.height + self.m_detailLabel.frame.origin.y + 10, self.m_addressView.frame.size.width, self.m_addressView.frame.size.height);
            
            self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_addressView.frame.size.height + self.m_addressView.frame.origin.y);
            
        }else{
            
            self.m_addressView.hidden = YES;
            
            // 计算view的坐标
            self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_detailLabel.frame.size.height + self.m_detailLabel.frame.origin.y + 10);
            
        }
        
        
        self.frame = self.m_view.frame;
        
        
        
        
    }else{
        
        self.m_photoView.hidden = NO;
        
        // 设置图片所在的view
        [self getimageViewWithArray:array withAddress:address];
        
    }

    
}

- (void)getimageViewWithArray:(NSMutableArray *)array withAddress:(NSString *)address{
    
    // 先清空view里面的所有控件
    for (id view in self.m_photoView.subviews) {
        [view removeFromSuperview];
    }
    
    int BtnW = 65;
    int BtnWS = 6;
    int BtnX = 6;
    
    int BtnH = 65;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    
    for (i = 0; i < [array count]; i++ ) {
        
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
        imageview.image = [array objectAtIndex:i];
        //        [imageview setImageWithURL: [NSURL URLWithString: [m_imageArray objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"]];
        // 添加图片手势
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)]];
        
        [self.m_photoView addSubview:imageview];
        
    }
    
    int getEndImageYH = (BtnH + BtnHS) * (i/4) + BtnY;
    
    // 根据图片数组的个数来判断view的坐标大小
    float heightY = 0.0f;
    
    if ( array.count > 0 && array.count <= 4) {
        
        heightY = 85.0f;
        
    }else if ( array.count > 4 && array.count <= 8 ){
        
        heightY = 160.0f;
        
        
    } else if ( array.count > 8 ){
        
        heightY = getEndImageYH + 75;
        
    }
    
    // 设置图片所在的view的大小
    self.m_photoView.frame = CGRectMake(self.m_photoView.frame.origin.x, self.m_detailLabel.frame.size.height + self.m_detailLabel.frame.origin.y + 10, self.m_detailLabel.frame.size.width, heightY);
    
    // 判断没有地理位置的情况下
    if ( address.length != 0 ) {
        
        self.m_addressView.hidden = NO;
        
        // 计算view的坐标大小
        self.m_addressView.frame = CGRectMake(self.m_addressView.frame.origin.x, self.m_photoView.frame.size.height + self.m_photoView.frame.origin.y + 10, self.m_addressView.frame.size.width, self.m_addressView.frame.size.height);
        
        self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_addressView.frame.size.height + self.m_addressView.frame.origin.y);
        
        
    }else{
        
        self.m_addressView.hidden = YES;
        
        // 计算view的坐标
        self.m_view.frame = CGRectMake(self.m_view.frame.origin.x, self.m_view.frame.origin.y, self.m_view.frame.size.width, self.m_photoView.frame.size.height + self.m_photoView.frame.origin.y + 10);
        
    }
    
    
    self.frame = self.m_view.frame;
    
    NSLog(@"frame = %f",self.frame.size.height);

    
    NSLog(@"height = %f",self.m_view.frame.size.height + self.m_view.frame.origin.y);
    
}

- (void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag);
    
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [self.m_imageList count]];
    
    for (int i = 0; i < [self.m_imageList count]; i++) {
        // 替换为中等尺寸图片
        //        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [self.m_imageArray objectAtIndex:i]];
        MJPhoto *photo = [[MJPhoto alloc] init];
        //        photo.url = [NSURL URLWithString: getImageStrUrl]; // 图片路径
        
        photo.image = [self.m_imageList objectAtIndex:i];
        
        UIImageView * imageView = (UIImageView *)[self.m_photoView viewWithTag: imageTap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
        
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}




@end


@implementation ZanCell

@synthesize delegate = _delegate;

- (void)awakeFromNib
{
    // Initialization code
    
    // 设置view的边框
    self.m_zanView.layer.borderWidth = 1.0;
    self.m_zanView.layer.borderColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:208/255.0 alpha:1.0].CGColor;//  [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0].CGColor;
        
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setZanTitle:(NSString *)string withCount:(NSString *)aCount withZanArray:(NSMutableArray *)zanArray{
    
    // 先删除已经加上来的view
    for (id view in self.m_zanView.subviews) {
        
        if ( [view isKindOfClass:[CXAHyperlinkLabel class]] || [view isKindOfClass:[UIImageView class]] ) {
            
            [view removeFromSuperview];
        }
    }

    // 1表示已赞过 0表示未赞过
    if ( [string isEqualToString:@"1"] ) {
        
        [self.m_zanBtn.titleLabel setTextColor:[UIColor grayColor]];
        self.m_zanBtn.enabled = NO;
        
        
    }else{
        
        [self.m_zanBtn.titleLabel setTextColor:[UIColor colorWithRed:29/255.0 green:175/255.0 blue:236/255.0 alpha:1.0]];
        self.m_zanBtn.enabled = YES;
        
    }
    
    if ( [aCount isEqualToString:@"0"] ) {
        
        self.m_zanView.hidden = YES;
        
    }else{
        
        self.m_zanView.hidden = NO;
    }
    
    
    [self.m_zanBtn setTitle:[NSString stringWithFormat:@"赞(%@)",aCount] forState:UIControlStateNormal];
    
    if ( zanArray.count != 0 ) {

        self.m_zanView.hidden = NO;
        
        self.m_arrowImagV.hidden = NO;

        // 添加赞的人的名称及名称可点击的事件
        NSString *zanstringman = @"" ;
        CGSize zansize;
        
        if ( zanArray.count == 0 ) {
            
            zansize.height = 0;
            
            self.m_zanView.hidden = YES;
            
        }else{
            
            self.m_zanView.hidden = NO;
            
            zanstringman = [[zanArray objectAtIndex:0]objectForKey:@"NickName"];
            
            //赞的人数组
            for (int iii = 1; iii < zanArray.count; iii++) {
                
                
                NSDictionary * zandic = [zanArray objectAtIndex:iii ];
                
                zanstringman = [NSString stringWithFormat:@"%@、%@",zanstringman,[zandic objectForKey:@"NickName"]];
                
            }
            
            
            zansize = [zanstringman sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(290, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            
            
            if (isIOS5) {
                UILabel * zanl = [[UILabel alloc]initWithFrame:CGRectMake(2, 10, 295, zansize.height)];
                zanl.numberOfLines = 0;
                zanl.backgroundColor = [UIColor clearColor];
                zanl.font = [UIFont fontWithName:@"Baskerville" size:13];
                zanl.text = [NSString stringWithFormat:@"        %@",zanstringman];
                [self.m_zanView addSubview:zanl];
                
            }else{
                
                NSArray *URLs;
                NSArray *URLRanges;
                NSAttributedString *as = [self attributedString:&URLs URLRanges:&URLRanges nicknamearray:zanArray];
                
                zan_label = [[CXAHyperlinkLabel alloc] initWithFrame:CGRectMake(2, 10, 295, zansize.height)];
                zan_label.numberOfLines = 0;
                zan_label.backgroundColor = [UIColor clearColor];
                zan_label.attributedText = as;
                [zan_label setURLs:URLs forRanges:URLRanges];
                
                zan_label.URLClickHandler = ^(CXAHyperlinkLabel *label, NSURL *URL, NSRange range, NSArray *textRects){
                    
                    //点击赞的人名称进入空间
                    if ( _delegate && [_delegate respondsToSelector:@selector(zanNameClicked:)] ) {
                        [_delegate performSelector:@selector(zanNameClicked:) withObject:[URL absoluteString]];
                    }
                    
                };
                
            }
            
            self.m_zanView.frame = CGRectMake(self.m_zanView.frame.origin.x, self.m_zanView.frame.origin.y, self.m_zanView.frame.size.width, zan_label.frame.size.height + 20);
            
            [self.m_zanView addSubview:zan_label];
            
            UIImageView * imagevc = [[UIImageView alloc]initWithFrame:CGRectMake(5,6, 18, 18)];
            imagevc.image = [UIImage imageNamed:@"zanyige.png"];
            
            [self.m_zanView addSubview:imagevc];
            
        }

    }else{
        
        
        self.m_zanView.hidden = YES;
        
        self.m_arrowImagV.hidden = YES;

    }
   

}

#pragma mark - privates
- (NSAttributedString *)attributedString:(NSArray *__autoreleasing *)outURLs
                               URLRanges:(NSArray *__autoreleasing *)outURLRanges
                           nicknamearray:(NSMutableArray *)array
{
    
    NSString *HTMLText ;
    
    if (array.count == 1) {
        
        //        HTMLText = [NSString stringWithFormat:@"<a href='%@' title=''>%@</a>、觉得赞",[[array objectAtIndex:0] objectForKey:@"MemberID"],[[array objectAtIndex:0] objectForKey:@"NickName"]];
        HTMLText = [NSString stringWithFormat:@"<a href='' title=''>        </a> <a href='%@' title=''>%@</a>",[[array objectAtIndex:0] objectForKey:@"MemberID"],[[array objectAtIndex:0] objectForKey:@"NickName"]];
        
        
    }else{
        
        HTMLText = [NSString stringWithFormat:@"<a href='' title=''>        </a> <a href='%@' title=''>%@</a>",[[array objectAtIndex:0] objectForKey:@"MemberID"],[[array objectAtIndex:0] objectForKey:@"NickName"]];
        
        for (int iii=1; iii<array.count; iii++) {
            
            NSDictionary * dic = [array objectAtIndex:iii];
            
            HTMLText = [NSString stringWithFormat:@"%@,<a href='%@' title=''>%@</a>",HTMLText,[dic objectForKey:@"MemberID"],[dic objectForKey:@"NickName"]];
            
        }
        
        //        HTMLText = [NSString stringWithFormat:@"%@、都觉得赞",HTMLText];
        HTMLText = [NSString stringWithFormat:@"%@",HTMLText];
        
    }
    
    
    
    NSArray *URLs;
    NSArray *URLRanges;
    UIColor *color = [UIColor blackColor];
    UIFont *font = [UIFont fontWithName:@"Baskerville" size:13];
    NSMutableParagraphStyle *mps = [[NSMutableParagraphStyle alloc] init];
    mps.lineSpacing = ceilf(font.pointSize *0.5);
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(0, 1);
    NSString *str = [NSString stringWithHTMLText:HTMLText baseURL:[NSURL URLWithString:@""] URLs:&URLs URLRanges:&URLRanges];
    NSMutableAttributedString *mas;
    if (isIOS5) {
        
        mas = [[NSMutableAttributedString alloc] initWithString:str attributes:@
               {
                   //                                              NSForegroundColorAttributeName : color,
                   //                                              NSFontAttributeName            : font,
                   //                                          NSParagraphStyleAttributeName  : mps,
                   //                                              NSShadowAttributeName          : shadow,
               }];
        [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            [mas addAttributes:@
             {
                 //                 NSForegroundColorAttributeName : [UIColor colorWithRed:25.0f/255.0f green:185.0f/255.0f blue:245.0f/255.0f alpha:1.0],
                 
             } range:[obj rangeValue]];
        }];
        
    }else
    {
        
        mas= [[NSMutableAttributedString alloc] initWithString:str attributes:@
              {
                  NSForegroundColorAttributeName : color,
                  NSFontAttributeName            : font,
                  //                                          NSParagraphStyleAttributeName  : mps,
                  NSShadowAttributeName          : shadow,
              }];
        [URLRanges enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            [mas addAttributes:@
             {
                 NSForegroundColorAttributeName : [UIColor colorWithRed:25.0f/255.0f green:185.0f/255.0f blue:245.0f/255.0f alpha:1.0],
                 
             } range:[obj rangeValue]];
        }];
    }
    
    
    *outURLs = URLs;
    *outURLRanges = URLRanges;
    
    return [mas copy];
    
}

@end
