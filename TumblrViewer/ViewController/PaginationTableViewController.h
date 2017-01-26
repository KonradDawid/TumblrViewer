//
//  PaginationTableViewController.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaginationTableViewController : UITableViewController
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSUInteger offset;
@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, assign) NSInteger total;
- (void)getNextPage;
- (void)resetPagination;
@end

