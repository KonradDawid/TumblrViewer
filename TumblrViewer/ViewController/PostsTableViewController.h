//
//  PostsTableViewController.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaginationTableViewController.h"
#import "MainViewController.h"
@class Post;
@class TumblrInfo;

@interface PostsTableViewController : PaginationTableViewController
- (void)appendNewPosts:(NSArray<Post*> *)posts offset:(NSUInteger)offset info:(TumblrInfo *)info;
- (void)showError;
@property (nonatomic, weak) id<PageRequestDelegate> delegate;
@end

