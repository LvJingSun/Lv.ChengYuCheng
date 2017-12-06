#import "NSDate+BBExtensions.h"

#import <sys/time.h>

@implementation NSDate (BBExtensions)

+ (long long)currentTimeMillis
{
    struct timeval t;
    gettimeofday(&t, NULL);
	
    return (((long long) t.tv_sec) * 1000) + (((long long) t.tv_usec) / 1000);
}

+ (NSDate*)dateFromMillis:(long long)millis
{
    return [NSDate dateWithTimeIntervalSince1970:(millis / 1000)];
}

@end