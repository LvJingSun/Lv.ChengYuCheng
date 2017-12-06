#import "SI.h"

@implementation SI
@synthesize from;
@synthesize sid;
@synthesize name;
@synthesize size;

-(NSString *) suffix{
    if(nil == name){
        return nil;
    }
    NSArray *part = [name componentsSeparatedByString:@"."];
    int partCount = [part count];
    if(partCount>1){
        return [part objectAtIndex:partCount-1];
    }else{
        return nil;
    }
}
-(BOOL) isImage{
    NSString *suffix = [self suffix];
    suffix = [suffix uppercaseString];
    if([@"JPG" isEqualToString:suffix] ||
       [@"JPEG" isEqualToString:suffix] ||
       [@"GIF" isEqualToString:suffix] ||
       [@"BMP" isEqualToString:suffix] ||
       [@"PNG" isEqualToString:suffix]){
        return YES;
    }
    return NO;
}

-(BOOL) isAudio{
    NSString *suffix = [self suffix];
    suffix = [suffix uppercaseString];
    if([@"AMR" isEqualToString:suffix] ||
       [@"CAF" isEqualToString:suffix] ||
       [@"WAV" isEqualToString:suffix]){
        return YES;
    }
    return NO;
}

-(void)dealloc{
    self.from = nil;
    self.sid = nil;
    self.name = nil;
    self.groupto = nil;
//    [super dealloc];
}
@end
