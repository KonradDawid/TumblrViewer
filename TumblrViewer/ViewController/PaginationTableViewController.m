//
//  PaginationTableViewController.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "PaginationTableViewController.h"

@interface PaginationTableViewController () <UIScrollViewDelegate>
@end

@implementation PaginationTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _isLoading = NO;
        _offset = 0;
        _limit = 20;
        _total = 0;
    }
    return self;
}

- (void)getNextPage {
}

- (BOOL)hasNextPage {
    return (self.total > 0 && self.offset < self.total);
}

- (void)resetPagination {
    self.offset = 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return;
    }
    
    CGFloat currentOffset = scrollView.contentOffset.y;
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    CGFloat scrolledPercentage = currentOffset / maximumOffset;
    
    if (scrolledPercentage > 0.75) {
        if ([self hasNextPage]) {
            [self getNextPage];
        }
    }
}

@end

