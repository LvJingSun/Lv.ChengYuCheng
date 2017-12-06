/*
 * This file is part of the HHImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>
#import "HHImageDownloader.h"
#import "HHImageOperation.h"

@interface HHImageDownloaderOperation : NSOperation <HHImageOperation>

@property (strong, nonatomic, readonly) NSURLRequest *request;
@property (assign, nonatomic, readonly) HHImageDownloaderOptions options;

- (id)initWithRequest:(NSURLRequest *)request
              options:(HHImageDownloaderOptions)options
             progress:(HHImageDownloaderProgressBlock)progressBlock
            completed:(HHImageDownloaderCompletedBlock)completedBlock
            cancelled:(void (^)())cancelBlock;

- (id)initWithRequest:(NSURLRequest *)request
              options:(HHImageDownloaderOptions)options
             progress:(HHImageDownloaderProgressBlock)progressBlock
            completed:(HHImageDownloaderCompletedBlock)completedBlock
            cancelled:(void (^)())cancelBlock
               dealed:(MJWebImageDealedBlock)dealedBlock;

@end
