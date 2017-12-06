//
//  YKCommonBanner.m
//  HuiHui
//
//  Created by mac on 13-11-22.
//  Copyright (c) 2013年 MaxLinksTec. All rights reserved.
//

#import "YKCommonBanner.h"

#import "CommonUtil.h"

#import "UIImageView+AFNetworking.h"

@implementation YKCommonBanner

@synthesize delegate;
@synthesize m_typeString;

@synthesize m_items;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (id)initWithFrame:(CGRect)frame withArray:(NSMutableArray *)array withType:(NSString *)aType{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        m_array = [[NSMutableArray alloc]initWithCapacity:0];
        
        m_items = [[NSMutableDictionary alloc]initWithCapacity:0];
        
        [m_array addObjectsFromArray:array];
        
        self.m_typeString = aType;
        
        // 名称
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 310, 21)];
        label.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        label.font = [UIFont systemFontOfSize:16.0f];
        label.backgroundColor = [UIColor clearColor];
        //        label.numberOfLines = 1;
        self.m_nameLabel = label;
        [self addSubview:self.m_nameLabel];
        
        // 价钱
        UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(5, 240, 200, 21)];
        price.textColor = [UIColor colorWithRed:47/255.0 green:163/255.0 blue:217/255.0 alpha:1.0];
        price.font = [UIFont systemFontOfSize:24.0f];
        price.backgroundColor = [UIColor clearColor];
        self.m_priceLabel = price;
        [self addSubview:self.m_priceLabel];
        
        // 原价
        UILabel *orignPrice = [[UILabel alloc]initWithFrame:CGRectMake(20, 231, 200, 21)];
        orignPrice.textColor = [UIColor colorWithRed:170/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];
        orignPrice.font = [UIFont systemFontOfSize:12.0f];
        orignPrice.backgroundColor = [UIColor clearColor];
        self.m_orignPriceLabel = orignPrice;
        [self addSubview:self.m_orignPriceLabel];
        
        // 下划线
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(20, 241, 200, 1)];
        line.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1.0];
        self.m_lineLabel = line;
        [self addSubview:self.m_lineLabel];
        
        // 打折
        UILabel *discount = [[UILabel alloc]initWithFrame:CGRectMake(WindowSizeWidth - 100, 230, 80, 21)];
        discount.textColor = [UIColor colorWithRed:240/255.0 green:127/255.0 blue:0/255.0 alpha:1.0];
        discount.font = [UIFont systemFontOfSize:18.0f];
        discount.backgroundColor = [UIColor clearColor];
        discount.textAlignment = NSTextAlignmentRight;
        self.m_discountLabel = discount;
        [self addSubview:self.m_discountLabel];
        
        UILabel *line_buttom = [[UILabel alloc]initWithFrame:CGRectMake(0, 259, WindowSizeWidth, 1)];
        line_buttom.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        
        [self addSubview:line_buttom];
        
		
		// 初始化scrollerView
		m_scrollerView = [[UIScrollView alloc] init];
        m_scrollerView.backgroundColor = [UIColor clearColor];
		m_scrollerView.delegate = self;
		m_scrollerView.pagingEnabled = YES;
		m_scrollerView.showsHorizontalScrollIndicator = NO;
		m_scrollerView.showsVerticalScrollIndicator = NO;
        m_scrollerView.bounces = NO;
		m_scrollerView.frame = CGRectMake(0, 30, WindowSizeWidth, 190);
        
        [self addSubview:m_scrollerView];
        // 设置pageControl
        CGRect pageControlFrame = CGRectMake(0, 210, WindowSizeWidth, 10);
        m_pageControl = [[GrayPageControl alloc]initWithFrame:pageControlFrame];
        m_pageControl.backgroundColor = [UIColor clearColor];//背景
        m_pageControl.inactiveImage = [UIImage imageNamed:@"white.png"];
        m_pageControl.activeImage = [UIImage imageNamed:@"blue.png"];
        
        m_pageControl.userInteractionEnabled = NO;
        
        [self addSubview:m_pageControl];
    }
    
    return self;
    
}

//- (void)initScollerView:(NSMutableArray *)array{

- (void)initScollerView:(NSMutableDictionary *)dic From:(NSString *)Fromstring{
        
	[m_array removeAllObjects];
    
    self.m_items = dic;
    
    if ([Fromstring isEqualToString:@"CC"]) {
        
        [m_array addObjectsFromArray:[dic objectForKey:@"Poster"]];
        
        [self initScollerView];
        
    }else if ([Fromstring isEqualToString:@"DP"]){
        
        NSArray * a =[dic objectForKey:@"more_image_urls"];
        
        if (a.count==0) {
            
            [m_array addObject:[self.m_items objectForKey:@"image_url"]];
            
            
        }else{
            
            [m_array addObjectsFromArray:[dic objectForKey:@"more_image_urls"]];

        }

        [self initScollerView_DP];
        
    }
    
    
}

- (void)initScollerView{
	
	if ( m_timer.isValid ) {
		
		[m_timer invalidate];
	}
    
    // 赋值
    self.m_nameLabel.text = [self.m_items objectForKey:@"SvcSimpleName"];
    self.m_priceLabel.text = [NSString stringWithFormat:@"%@元",[self.m_items objectForKey:@"Price"]];
    
    self.m_orignPriceLabel.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"OriginalPrice"]];
    
    self.m_discountLabel.text = [NSString stringWithFormat:@"%.2f折",([[self.m_items objectForKey:@"Price"] floatValue] / [[self.m_items objectForKey:@"OriginalPrice"] floatValue] * 10)];
    
    // 计算label显示的位置
    CGSize size = [self.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:24.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize size1 = [self.m_orignPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_priceLabel.frame = CGRectMake(5, 230, size.width, 21);
    
    self.m_orignPriceLabel.frame = CGRectMake(5 + size.width + 20, 233, size1.width, 21);
    
    self.m_lineLabel.frame = CGRectMake(5 + size.width + 15, 243, size1.width + 10, 1);
    
    
    CGFloat Width = m_scrollerView.frame.size.width;
    CGFloat Height = m_scrollerView.frame.size.height - 5;
    
    if ( m_array.count != 0 ) {
        
        for (int i = 0; i < m_array.count; i ++) {
            
            NSMutableDictionary *dic = [m_array objectAtIndex:i];
            
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth * i, 0, WindowSizeWidth, 200)];
            imgV.backgroundColor = [UIColor clearColor];
            
            // 图片赋值
            NSString *path = [dic objectForKey:@"ApplePoster960"];
                        
            UIImage *reSizeImage = [self.imageCache getImage:path];
            if (reSizeImage != nil) {
                imgV.image = reSizeImage;
                return;
            }
            
            [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                        placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                                 success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                     
                                     imgV.image = image;
//                                     imgV.image = [self scaleImage:image toScale:0.3];
                                     //[CommonUtil scaleImage:image toSize:CGSizeMake(225, 140)];//
                                     
                                     imgV.contentMode = UIViewContentModeScaleToFill;
                                     
                                     [self.imageCache addImage:imgV.image andUrl:path];
                                 }
                                 failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                     
                                 }];
            
            
            UIButton *lastbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [lastbtn addTarget:self action:@selector(clickedImgVAction:) forControlEvents:UIControlEventTouchUpInside];
            lastbtn.tag = i;
            lastbtn.frame = CGRectMake(WindowSizeWidth*i, 0, Width, Height);
            
            [m_scrollerView addSubview:imgV];
            [m_scrollerView addSubview:lastbtn];
            
        }
        
        [m_scrollerView setContentSize:CGSizeMake(Width * m_array.count, Height)];
        
        m_pageControl.numberOfPages = m_array.count;
        
        m_pageControl.currentPage = 0;
        
    }else{
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WindowSizeWidth, 200)];
        
        imgV.image = [UIImage imageNamed:@"invite_reg_no_photo.png"];
        
        [m_scrollerView addSubview:imgV];
        
    }
    
    /*
     m_timer = [NSTimer scheduledTimerWithTimeInterval:3.0f
     target:self
     selector:@selector(scrollToNextPage:)
     userInfo:nil
     repeats:YES];
     //default--> run at once
     //timewithinterval addrun ->then run
     //tablview->trackingmode
     //Mode->event lines
     
     [[NSRunLoop currentRunLoop]addTimer:m_timer forMode:NSRunLoopCommonModes];
     */
    
}


-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize {
    
    // 计算图片显示的大小
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width,image.size.height));
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma UIScrollView delegate
-(void)scrollToNextPage:(id)sender
{
    //    int pageNum = m_pageControl.currentPage;
    //    CGSize viewSize = m_scrollerView.frame.size;
    //    CGRect rect = CGRectMake((pageNum + 2) * viewSize.width, 0, viewSize.width, viewSize.height);
    //    [m_scrollerView scrollRectToVisible:rect animated:YES];
    //    pageNum ++;
    //
    //    if ( pageNum == m_array.count ) {
    //        CGRect newRect=CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
    //        [m_scrollerView scrollRectToVisible:newRect animated:YES];
    //    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == m_scrollerView) {
        CGFloat pageWidth = WindowSizeWidth;
        int page = floor((m_scrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        m_pageControl.currentPage = page;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == m_scrollerView) {
        CGFloat pageWidth = scrollView.frame.size.width;
		int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		if (page != m_pageControl.currentPage)
		{
            if (page <= m_pageControl.numberOfPages) {
                m_pageControl.currentPage = page;
                
            }
		}
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    [m_timer invalidate];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    m_timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollToNextPage:) userInfo:nil repeats:YES];
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = m_scrollerView.frame.size.width;
//    CGFloat pageHeigth = m_scrollerView.frame.size.height;
//    int currentPage = floor((m_scrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//
//    if ( currentPage == 0 ) {
//
//        [m_scrollerView scrollRectToVisible:CGRectMake(pageWidth*m_array.count, 0, pageWidth, pageHeigth) animated:NO];
//        m_pageControl.currentPage = m_array.count - 1;
//
//        return;
//
//    }else if( currentPage == [m_array count] + 1 ){
//
//        [m_scrollerView scrollRectToVisible:CGRectMake(pageWidth, 0, pageWidth, pageHeigth) animated:NO];
//        m_pageControl.currentPage = 0;
//
//        return;
//    }
//
//    m_pageControl.currentPage = currentPage - 1;
//}

- (void)clickedImgVAction:(id)sender{
    
    UIButton *tempBtn = (UIButton *)sender;
    NSInteger index = tempBtn.tag;
    
    if ( delegate && [delegate respondsToSelector:@selector(clickBannerAction:)] ) {
        
        NSString *indexStr = [NSString stringWithFormat:@"%li",(long)index];
        [delegate performSelector:@selector(clickBannerAction:) withObject:indexStr];
        
    }
    
}

#pragma mark - Protol delegate
- (void)clickBannerAction:(NSString *)aIndex{
    
    NSLog(@"aaa%@",aIndex);
    
}


//大众点评数据
- (void)initScollerView_DP{
	
	if ( m_timer.isValid ) {
		
		[m_timer invalidate];
	}
    
    // 赋值
    //名称
    self.m_nameLabel.text = [self.m_items objectForKey:@"title"];
    //现价
    self.m_priceLabel.text = [NSString stringWithFormat:@"%@元",[self.m_items objectForKey:@"current_price"]];
    //原价
    self.m_orignPriceLabel.text = [NSString stringWithFormat:@"￥%@",[self.m_items objectForKey:@"list_price"]];
    //折扣
    self.m_discountLabel.text = [NSString stringWithFormat:@"%.2f折",([[self.m_items objectForKey:@"current_price"] floatValue] / [[self.m_items objectForKey:@"list_price"] floatValue] * 10)];
    
    // 计算label显示的位置
    CGSize size = [self.m_priceLabel.text sizeWithFont:[UIFont systemFontOfSize:24.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize size1 = [self.m_orignPriceLabel.text sizeWithFont:[UIFont systemFontOfSize:12.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 21) lineBreakMode:NSLineBreakByWordWrapping];
    
    self.m_priceLabel.frame = CGRectMake(5, 230, size.width, 21);
    
    self.m_orignPriceLabel.frame = CGRectMake(5 + size.width + 20, 233, size1.width, 21);
    
    self.m_lineLabel.frame = CGRectMake(5 + size.width + 15, 243, size1.width + 10, 1);
    
    
    CGFloat Width = m_scrollerView.frame.size.width;
    CGFloat Height = m_scrollerView.frame.size.height - 5;
    
    
    
    for (int i = 0; i < m_array.count; i ++) {
        
        NSString *path =  [m_array objectAtIndex:i];
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(WindowSizeWidth * i, 0, WindowSizeWidth, 190)];
        imgV.backgroundColor = [UIColor clearColor];
        
        // 图片赋值
        UIImage *reSizeImage = [self.imageCache getImage:path];
        if (reSizeImage != nil) {
            imgV.image = reSizeImage;
            return;
        }
        
        [imgV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]]
                    placeholderImage:[UIImage imageNamed:@"invite_reg_no_photo.png"]
                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
//                                 imgV.image = [self scaleImage:image toScale:0.3];
                                 //[CommonUtil scaleImage:image toSize:CGSizeMake(225, 140)];//
                                 imgV.image = image;
                                 imgV.contentMode = UIViewContentModeScaleToFill;
                                 
                                 [self.imageCache addImage:imgV.image andUrl:path];
                             }
                             failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                 
                             }];
        
        
        UIButton *lastbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [lastbtn addTarget:self action:@selector(clickedImgVAction:) forControlEvents:UIControlEventTouchUpInside];
        lastbtn.tag = i;
        lastbtn.frame = CGRectMake(WindowSizeWidth*i, 0, Width, Height);
        
        [m_scrollerView addSubview:imgV];
        [m_scrollerView addSubview:lastbtn];
        
    }
    
    [m_scrollerView setContentSize:CGSizeMake(Width * m_array.count, Height)];
    
    m_pageControl.numberOfPages = m_array.count;
    
    m_pageControl.currentPage = 0;
    
    
    
}


@end
