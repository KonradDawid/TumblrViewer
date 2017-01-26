//
//  PhotoPost.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface PhotoPost: Post
@property (nonatomic, copy) NSString *caption;
@property (nonatomic, copy) NSArray<NSString*> *photos;
@property (nonatomic, copy) NSArray<NSString*> *tags;
@property (nonatomic, strong) NSString *tagsString;
-(instancetype)initWithIdentifier:(NSString *)identifier postedAt:(NSTimeInterval)postedAt caption:(NSString *)caption photos:(NSArray<NSString*> *)photos tags:(NSArray<NSString*> *)tags;

@end
