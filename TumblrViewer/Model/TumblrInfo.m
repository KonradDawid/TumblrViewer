//
//  TumblrInfo.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "TumblrInfo.h"

@implementation TumblrInfo
- (instancetype)initWithTitle:(NSString *)title postsCount:(NSUInteger)postsCount {
    self = [super init];
    if (self) {
        _title = [title copy];
        _postsCount = postsCount;
    }
    return self;
}
@end
