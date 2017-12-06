@interface ChatGroup : NSObject

@property (strong) id data;
@property (strong) NSMutableArray *members;

-(NSString *) getName;
-(void) changeName:(NSString *) freshName;
-(BOOL) isSelfOwner;
-(NSString *) groupId;
-(NSString *) groupIdMain;
+(BOOL) nameExist:(NSString *) name;
-(BOOL) removeMember:(NSString *) userId;
@end
//<item
//jid="e45dfa8e-8e2e-4e85-8b2d-6e8178398c00@conference.localhost"
//name="testgroup"
//node="ceshi1@localhost"/>

//<item affiliation="owner"//member
//nickname="ceshi1"
//jid="ceshi1@localhost"
//id="2"
//name="测试1"
//email="ceshi1@126.com"
//sex="1"
//quicksearchcode="ce,shi,1"/>
