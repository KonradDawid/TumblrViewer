//
//  TumblrParser.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TumblrInfo;
@class Post;

@interface TumblrParser : NSObject
+ (TumblrInfo *)infoFromData:(NSData *)data;
+ (NSArray<Post*> *)postsFromData:(NSData *)data;
@end

