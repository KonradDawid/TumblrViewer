//
//  TumblrClient.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "TumblrClient.h"
#import <AFNetworking.h>
#import "Constants.h"
#import "TumblrParser.h"
#import "TumblrInfo.h"

@interface TumblrClient()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation TumblrClient

+ (instancetype)sharedClient {
    static TumblrClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TumblrClient alloc] init];;
    });
    return _sharedClient;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return self;
}

-(void)getPostsForUsername:(NSString*)username withInfo:(BOOL)info offset:(NSUInteger)offset success:(void(^)(NSArray<Post *>*, TumblrInfo*))successBlock andFailure:(void(^)(NSError* error))failureBlock {
    
    if (username == nil || [username isEqualToString:@""]) { return; }
    
    NSString *path = [NSString stringWithFormat:@"http://%@.tumblr.com/api/read",[username stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]];
    
    [self.sessionManager GET:path parameters:@{@"start":@(offset), @"num":@(20)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject == nil) {
            if (failureBlock) {
                failureBlock([NSError errorWithDomain:kErrorDomain code:1 userInfo:@{NSLocalizedDescriptionKey: @"No data from API"}]);
            }
            return;
        }
        
        TumblrInfo *tumblrInfo;
        
        if (info) {
            tumblrInfo = [TumblrParser infoFromData:responseObject];
        }
        
        NSArray<Post*> *posts =  [TumblrParser postsFromData:responseObject];
        
        if (posts == nil) {
            if (failureBlock) {
                failureBlock([NSError errorWithDomain:kErrorDomain code:2 userInfo:@{NSLocalizedDescriptionKey: @"Error parsing data"}]);
            }
            return;
        }
        
        if (successBlock) {
            successBlock(posts, tumblrInfo);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end

