//
//  TumblrClient.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Post;
@class TumblrInfo;

@interface TumblrClient : NSObject
+ (instancetype)sharedClient;
- (void)getPostsForUsername:(NSString *)username withInfo:(BOOL)info offset:(NSUInteger)offset success:(void(^)(NSArray<Post *> *, TumblrInfo *))successBlock andFailure:(void(^)(NSError *error))failureBlock;
@end

