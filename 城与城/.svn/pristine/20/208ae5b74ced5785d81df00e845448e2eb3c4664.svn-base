#import "FileTransfer.h"
#import "Context.h"
#import "TURNSocket.h"
#import "NSDate+BBExtensions.h"
#import "Constants.h"
#import "AppService.h"
@implementation FileTransfer
@synthesize si;
-(void)turnSocket:(TURNSocket *)sender didSucceedWithReceiveData:(NSData *)data{
    NSLog(@"turnSocket didSucceedWithReceiveData length %d",[data length]);
    sender.done = YES;
    [sender relaseSomething];
    NSLog(@"si %@",si);
    if(data && si){
        [AppService fileReceive:si data:data];
    }
    
}

- (void)turnSocket:(TURNSocket *)sender didSucceed:(GCDAsyncSocket *)socket{
    NSLog(@"turnSocket didSucceed");    
    //TODO UPDATE DAO SEND ITEM READ
}

- (void)turnSocketDidFail:(TURNSocket *)sender{
    NSLog(@"turnSocketDidFail");
}
-(void)dealloc{
    self.si = nil;
    [super dealloc];
}
@end
