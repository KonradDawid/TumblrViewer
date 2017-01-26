//
//  PhotoPost.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "PhotoPost.h"

@interface PhotoPost (Protected)
-(NSString *)tagsStringFromTags:(NSArray<NSString*> *)tags;
@end

@implementation PhotoPost

-(instancetype)initWithIdentifier:(NSString *)identifier postedAt:(NSTimeInterval)postedAt caption:(NSString *)caption photos:(NSArray<NSString*> *)photos tags:(NSArray<NSString*> *)tags {
    self = [super initWithIdentifier:identifier postType:PostTypePhoto postedAt:postedAt];
    if (self) {
        _caption = [caption copy];
        _photos = [photos copy];
        _tags = [tags copy];
        _tagsString = [self tagsStringFromTags:tags];
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat: @"id:%@, postType:%@, caption: %@, tagsString:%@", self.identifier, @(self.postType), self.caption, self.tagsString];
}

@end

