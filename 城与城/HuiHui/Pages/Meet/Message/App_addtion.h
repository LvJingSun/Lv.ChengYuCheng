#import "DDXML.h"
@interface NSObject (App)
-(void) alert:(NSString *) msg;
-(void) alert:(NSString *) title msg:(NSString *) msg;
-(void) alert:(NSString *) title msg:(NSString *) msg delegate:(id) delegate cancelText:(NSString *) cancelText otherText:(NSString *)otherText;
@end

@interface UIView (App)
-(void) removeAllSub;
-(void) hideWithAnimation;
-(UITableViewCell *) getParentCell;
@end


@interface NSString (App)
-(BOOL) contain:(NSString *) text;
-(BOOL) isMobileNumber;
-(BOOL) isEmail;
@end

@interface UIImageView (App)
-(void) setImage:(UIImage *)image animate:(BOOL) animate;
@end

@interface UITableView (App)
-(void) addEmptyFooter;
-(void)registerCell2:(NSArray *)nibFileNames;
@end

@interface NSArray (App)
-(NSString *) joinWith:(NSString *) v withKey:(NSString *) key;
-(NSString *) country_name;
-(NSString *) country_nameSort;
-(int) country_code;
@end


@interface UIButton (App)
-(void) setImage:(BOOL) status y:(NSString *)y n:(NSString *) n;
-(void) setImage:(NSString *) imageName;
-(void) setBgImage:(NSString *) imageName;
-(void) setSelector:(SEL) selector;
-(void) setTitle:(NSString *) title;
@end

@interface UIColor (HexString)
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

@interface DDXMLElement (App)
- (NSString *) valueInSub:(NSString *) key;
- (DDXMLElement *) firstInSub:(NSString *) key;
@end
