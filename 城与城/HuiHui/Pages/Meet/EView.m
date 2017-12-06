#import "EView.h"
#import "Configuration.h"

static EView *instance;
static id delegate;


@implementation EView

+(void) setEmotionDelegate:(id) freshDelegate{

    delegate = freshDelegate;
}


+ (EView *) instance{
    if (nil == instance) {
        EView *sv = [[EView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        sv.backgroundColor = [UIColor whiteColor];
        EPanelView *eView = [[EPanelView alloc] initWithFrame:CGRectMake(0, 0, 960, 216)];
        sv.contentSize = eView.frame.size;
        sv.pagingEnabled = YES;
        [sv addSubview:eView];
        
        UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(141, 187, 38, 36)];
        pc.numberOfPages = 2;
        pc.currentPage = 1;
        [sv addSubview:pc];
        
        instance = sv;
    
    }
    return instance;
}
@end

@implementation EPanelView
    
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        for(int i=0; i<3; i++){
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                UIImage *image = [UIImage imageNamed:@"e_delete_btn.png"];
                [btn addTarget:self
                        action:@selector(emotionDeleteTap)
              forControlEvents:UIControlEventTouchUpInside];
                [btn setImage:image forState:UIControlStateNormal];
                btn.frame = CGRectMake(214+320*i, 173, 39, 39);
                [self addSubview:btn];
            }
            
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self
                        action:@selector(emotionSentTap)
              forControlEvents:UIControlEventTouchUpInside];
                btn.frame = CGRectMake(260+320*i, 177, 50, 30);
                
                UIImage *img = [[UIImage imageNamed:@"btn_green_pa.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:12];
                
                [btn setBackgroundImage:img forState:UIControlStateNormal];
                [btn setTitle:@"发送" forState:UIControlStateNormal];
                [self addSubview:btn];
            }
        }
        int x = 6, y= 4;
        int pageSpan = 0;
        for (int i=1000; i<1105; i++) {
            NSString *imageName = [NSString stringWithFormat:@"f%d.png",i];
            imageName = [imageName stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@""];
            UIImage *image = [UIImage imageNamed:imageName];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i;
            [btn addTarget:self
                    action:@selector(emotionTap:)
          forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:image forState:UIControlStateNormal];
            btn.frame = CGRectMake(x+pageSpan, y, 30, 30);
            [self addSubview:btn];
            x += 40;
            if (i == 1044 || i == 1089) {
                x+=120;
            }
            if (x == 326) {
                x = 6;
                y += 34;
                if (y == 208) {
                    y = 4;
                    pageSpan += 320;
                }
            }
        }
    }
    return self;
}

- (void)emotionDeleteTap{
    if (delegate && [delegate respondsToSelector:@selector(emotionDeleteTap)]) {
        [delegate performSelector:@selector(emotionDeleteTap) withObject:nil];
    }
}

- (void)emotionSentTap{
    if (delegate && [delegate respondsToSelector:@selector(emotionSentTap)]) {
        [delegate performSelector:@selector(emotionSentTap) withObject:nil];
    }
}

- (void)emotionTap:(UIButton *) btn{
    NSString *name = [NSString stringWithFormat:@"%d",btn.tag];
    name = [name substringFromIndex:1];
    NSString *text = [NSString stringWithFormat:@"/:EK%@:",name];

    if (delegate && [delegate respondsToSelector:@selector(inputEmotion:)]) {
        [delegate performSelector:@selector(inputEmotion:) withObject:text];
    }
}
@end
