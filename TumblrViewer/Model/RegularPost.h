//
//  RegularPost.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Post.h"

@interface RegularPost: Post
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSArray<NSString*> *tags;
@property (nonatomic, strong) NSString *tagsString;
-(instancetype)initWithIdentifier:(NSString *)identifier postedAt:(NSTimeInterval)postedAt title:(NSString *)title body:(NSString *)body tags:(NSArray<NSString*> *)tags;
@end

