//
//  RegularPost.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "RegularPost.h"

@interface RegularPost (Protected)
-(NSString *)tagsStringFromTags:(NSArray<NSString*> *)tags;
@end

@implementation RegularPost

-(instancetype)initWithIdentifier:(NSString *)identifier postedAt:(NSTimeInterval)postedAt title:(NSString *)title body:(NSString *)body tags:(NSArray<NSString*> *)tags  {
    self = [super initWithIdentifier:identifier postType:PostTypeRegular postedAt:postedAt];
    if (self) {
        _title = [title copy];
        _body = [body copy];
        _tags = [tags copy];
        _tagsString = [self tagsStringFromTags:tags];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat: @"id:%@, postType:%@, title: %@, tagsString:%@", self.identifier, @(self.postType), self.title, self.tagsString];
}

@end

