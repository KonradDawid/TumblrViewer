//
//  Post.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PostType) {
    PostTypeRegular,
    PostTypePhoto,
    PostTypeOther
};

@interface Post: NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, assign) PostType postType;
@property (nonatomic, assign) NSTimeInterval postedAt;
- (instancetype)initWithIdentifier:(NSString *)identifier postType:(PostType)postType postedAt:(NSTimeInterval)postedAt;
@end
