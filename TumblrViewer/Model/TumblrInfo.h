//
//  TumblrInfo.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TumblrInfo : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSUInteger postsCount;
- (instancetype)initWithTitle:(NSString *)title postsCount:(NSUInteger)postsCount;
@end
