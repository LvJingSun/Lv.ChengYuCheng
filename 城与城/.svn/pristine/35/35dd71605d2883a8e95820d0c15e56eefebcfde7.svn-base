/*
 * This file is part of the HHImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "HHImageManager.h"
#import "UIImage+GIF.h"
#import <objc/message.h>

@interface HHImageCombinedOperation : NSObject <HHImageOperation>

@property (assign, nonatomic, getter = isCancelled) BOOL cancelled;
@property (copy, nonatomic) void (^cancelBlock)();
@property (strong, nonatomic) NSOperation *cacheOperation;

@end

@interface HHImageManager ()

@property (strong, nonatomic, readwrite) HHImage *imageCache;
@property (strong, nonatomic, readwrite) HHImageDownloader *imageDownloader;
@property (strong, nonatomic) NSMutableArray *failedURLs;
@property (strong, nonatomic) NSMutableArray *runningOperations;

@end

@implementation HHImageManager

+ (id)sharedManager
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{instance = self.new;});
    return instance;
}

- (id)init
{
    if ((self = [super init]))
    {
        _imageCache = [self createCache];
        _imageDownloader = HHImageDownloader.new;
        _failedURLs = NSMutableArray.new;
        _runningOperations = NSMutableArray.new;
    }
    return self;
}

- (HHImage *)createCache
{
    return [HHImage sharedImageCache];
}

- (NSString *)cacheKeyForURL:(NSURL *)url
{
    if (self.cacheKeyFilter)
    {
        return self.cacheKeyFilter(url);
    }
    else
    {
        return [url absoluteString];
    }
}

- (id<HHImageOperation>)downloadWithURL:(NSURL *)url options:(HHImageOptions)options progress:(HHImageDownloaderProgressBlock)progressBlock completed:(HHImageCompletedWithFinishedBlock)completedBlock
{
    return [self downloadWithURL:url options:options progress:progressBlock completed:completedBlock dealed:nil];
}

- (id<HHImageOperation>)downloadWithURL:(NSURL *)url options:(HHImageOptions)options progress:(HHImageDownloaderProgressBlock)progressBlock completed:(HHImageCompletedWithFinishedBlock)completedBlock dealed:(MJWebImageDealedBlock)dealedBlock
{    
    // Very common mistake is to send the URL using NSString object instead of NSURL. For some strange reason, XCode won't
    // throw any warning for this type mismatch. Here we failsafe this error by allowing URLs to be passed as NSString.
    if ([url isKindOfClass:NSString.class])
    {
        url = [NSURL URLWithString:(NSString *)url];
    }

    // Prevents app crashing on argument type error like sending NSNull instead of NSURL
    if (![url isKindOfClass:NSURL.class])
    {
        url = nil;
    }

    __block HHImageCombinedOperation *operation = HHImageCombinedOperation.new;
    __weak HHImageCombinedOperation *weakOperation = operation;
    
    BOOL isFailedUrl = NO;
    @synchronized(self.failedURLs)
    {
        isFailedUrl = [self.failedURLs containsObject:url];
    }

    if (!url || !completedBlock || (!(options & HHImageRetryFailed) && isFailedUrl))
    {
        if (completedBlock)
        {
            dispatch_main_sync_safe(^
            {
                NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
                completedBlock(nil, error, HHImageTypeNone, YES);
            });
        }
        return operation;
    }

    @synchronized(self.runningOperations)
    {
        [self.runningOperations addObject:operation];
    }
    NSString *key = [self cacheKeyForURL:url];

    operation.cacheOperation = [self.imageCache queryDiskCacheForKey:key done:^(UIImage *image, HHImageType cacheType)
    {
        if (operation.isCancelled)
        {
            @synchronized(self.runningOperations)
            {
                [self.runningOperations removeObject:operation];
            }

            return;
        }

        if ((!image || options & HHImageRefreshCached) && (![self.delegate respondsToSelector:@selector(imageManager:shouldDownloadImageForURL:)] || [self.delegate imageManager:self shouldDownloadImageForURL:url]))
        {
            if (image && options & HHImageRefreshCached)
            {
                dispatch_main_sync_safe(^
                {
                    // If image was found in the cache bug HHImageRefreshCached is provided, notify about the cached image
                    // AND try to re-download it in order to let a chance to NSURLCache to refresh it from server.
                    completedBlock(image, nil, cacheType, YES);
                });
            }

            // download if no image or requested to refresh anyway, and download allowed by delegate
            HHImageDownloaderOptions downloaderOptions = 0;
            if (options & HHImageLowPriority) downloaderOptions |= HHImageDownloaderLowPriority;
            if (options & HHImageProgressiveDownload) downloaderOptions |= HHImageDownloaderProgressiveDownload;
            if (options & HHImageRefreshCached) downloaderOptions |= HHImageDownloaderUseNSURLCache;
            if (image && options & HHImageRefreshCached)
            {
                // force progressive off if image already cached but forced refreshing
                downloaderOptions &= ~HHImageDownloaderProgressiveDownload;
                // ignore image read from NSURLCache if image if cached but force refreshing
                downloaderOptions |= HHImageDownloaderIgnoreCachedResponse;
            }
            id<HHImageOperation> subOperation = [self.imageDownloader downloadImageWithURL:url options:downloaderOptions progress:progressBlock completed:^(UIImage *downloadedImage, NSData *data, NSError *error, BOOL finished)
            {                
                if (weakOperation.isCancelled)
                {
                    dispatch_main_sync_safe(^
                    {
                        completedBlock(nil, nil, HHImageTypeNone, finished);
                    });
                }
                else if (error)
                {
                    dispatch_main_sync_safe(^
                    {
                        completedBlock(nil, error, HHImageTypeNone, finished);
                    });

                    if (error.code != NSURLErrorNotConnectedToInternet)
                    {
                        @synchronized(self.failedURLs)
                        {
                            [self.failedURLs addObject:url];
                        }
                    }
                }
                else
                {
                    BOOL cacheOnDisk = !(options & HHImageCacheMemoryOnly);

                    if (options & HHImageRefreshCached && image && !downloadedImage)
                    {
                        // Image refresh hit the NSURLCache cache, do not call the completion block
                    }
                    // NOTE: We don't call transformDownloadedImage delegate method on animated images as most transformation code would mangle it
                    else if (downloadedImage && !downloadedImage.images && [self.delegate respondsToSelector:@selector(imageManager:transformDownloadedImage:withURL:)])
                    {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^
                        {
                            UIImage *transformedImage = [self.delegate imageManager:self transformDownloadedImage:downloadedImage withURL:url];

                            dispatch_main_sync_safe(^
                            {
                                completedBlock(transformedImage, nil, HHImageTypeNone, finished);
                            });

                            if (transformedImage && finished)
                            {
                                NSData *dataToStore = [transformedImage isEqual:downloadedImage] ? data : nil;
                                [self.imageCache storeImage:transformedImage imageData:dataToStore forKey:key toDisk:cacheOnDisk];
                            }
                        });
                    }
                    else
                    {
                        dispatch_main_sync_safe(^
                        {
                            completedBlock(downloadedImage, nil, HHImageTypeNone, finished);
                        });

                        if (downloadedImage && finished)
                        {
                            [self.imageCache storeImage:downloadedImage imageData:data forKey:key toDisk:cacheOnDisk];
                        }
                    }
                }

                if (finished)
                {
                    @synchronized(self.runningOperations)
                    {
                        [self.runningOperations removeObject:operation];
                    }
                }
            } dealed:dealedBlock];
            operation.cancelBlock = ^{[subOperation cancel];};
        }
        else if (image)
        {
            dispatch_main_sync_safe(^
            {
                completedBlock(image, nil, cacheType, YES);
            });
            @synchronized(self.runningOperations)
            {
                [self.runningOperations removeObject:operation];
            }
        }
        else
        {
            // Image not in cache and download disallowed by delegate
            dispatch_main_sync_safe(^
            {
                completedBlock(nil, nil, HHImageTypeNone, YES);
            });
            @synchronized(self.runningOperations)
            {
                [self.runningOperations removeObject:operation];
            }
        }
    }];

    return operation;
}

- (void)cancelAll
{
    @synchronized(self.runningOperations)
    {
        [self.runningOperations makeObjectsPerformSelector:@selector(cancel)];
        [self.runningOperations removeAllObjects];
    }
}

- (BOOL)isRunning
{
    return self.runningOperations.count > 0;
}

@end

@implementation HHImageCombinedOperation

- (void)setCancelBlock:(void (^)())cancelBlock
{
    if (self.isCancelled)
    {
        if (cancelBlock) cancelBlock();
    }
    else
    {
        _cancelBlock = [cancelBlock copy];
    }
}

- (void)cancel
{
    self.cancelled = YES;
    if (self.cacheOperation)
    {
        [self.cacheOperation cancel];
        self.cacheOperation = nil;
    }
    if (self.cancelBlock)
    {
        self.cancelBlock();
        self.cancelBlock = nil;
    }
}

@end
