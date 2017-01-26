//
//  Post.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "Post.h"

@implementation Post

- (instancetype)initWithIdentifier:(NSString *)identifier postType:(PostType)postType postedAt:(NSTimeInterval)postedAt {
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
        _postType = postType;
        _postedAt = postedAt;
    }
    return self;
}

- (NSString *)tagsStringFromTags:(NSArray<NSString*> *)tags {
    NSMutableString *tagsString = [NSMutableString string];
    for (NSString* tag in tags) {
        [tagsString appendFormat:@"#%@ ", tag];
    }
    return [tagsString copy];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"id:%@, postType:%@", self.identifier, @(self.postType)];
}

@end

