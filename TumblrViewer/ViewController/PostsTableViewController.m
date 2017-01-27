//
//  PostsTableViewController.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "PostsTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "PhotoPostTableViewCell.h"
#import "RegularPostTableViewCell.h"
#import "UnavailableTableViewCell.h"
#import "PhotoPost.h"
#import "RegularPost.h"
#import "TumblrClient.h"
#import "TumblrInfo.h"
#import "ErrorView.h"

@interface PostsTableViewController ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSMutableArray<Post*>* posts;
@end

@implementation PostsTableViewController

static NSString* const photoPostCellIdentifier = @"photoPostCellIdentifier";
static NSString* const regularPostCellIdentifier = @"regularPostCellIdentifier";
static NSString* const unavailablePostCellIdentifier = @"unavailablePostCellIdentifier";

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    if (self = [super initWithNibName:nibName bundle:nibBundle]) {
        
        _posts = [NSMutableArray array];
    }
    return self;
}

#pragma mark - UIViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200.0f;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerClass:[PhotoPostTableViewCell class] forCellReuseIdentifier:photoPostCellIdentifier];
    [self.tableView registerClass:[RegularPostTableViewCell class] forCellReuseIdentifier:regularPostCellIdentifier];
    [self.tableView registerClass:[UnavailableTableViewCell class] forCellReuseIdentifier:unavailablePostCellIdentifier];
}

#pragma mark - Data methods

- (void)getNextPage {
    [super getNextPage];
    
    self.isLoading = YES;
    
    if ([self.delegate respondsToSelector:@selector(didRequestNextPageWithInfo:offset:)]) {
        [self.delegate didRequestNextPageWithInfo:NO offset:self.offset];
    }
}

- (void)appendNewPosts:(NSArray<Post*> *)posts offset:(NSUInteger)offset info:(TumblrInfo *)info {
    self.tableView.backgroundView = nil;
    
    // posts for new username, clearing data for previous username
    if (offset == 0) {
        [self.posts removeAllObjects];
        [self.tableView setContentOffset:CGPointZero animated:NO];
        [self resetPagination];
    }
    
    if (info != nil) {
        self.total = info.postsCount;
    }
    
    [self.posts addObjectsFromArray:posts];
    self.offset = [self.posts count];
    [self.tableView reloadData];
    self.isLoading = NO;
}

- (void)showError {
    
    self.isLoading = NO;
    
    self.tableView.backgroundView = [[ErrorView alloc]initWithFrame:self.view.bounds];
    [self.posts removeAllObjects];
    [self.tableView reloadData];
}


#pragma mark - UITableView dataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.posts[indexPath.row];
    if (post.postType == PostTypeRegular) {
        RegularPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:regularPostCellIdentifier forIndexPath:indexPath];
        [self configureRegularCell:cell forRowAtIndexPath:indexPath];
        return cell;
    } else if (post.postType == PostTypePhoto) {
        PhotoPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:photoPostCellIdentifier forIndexPath:indexPath];
        [self configurePhotoCell:cell forRowAtIndexPath:indexPath];
        return cell;
    } else {
        UnavailableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unavailablePostCellIdentifier forIndexPath:indexPath];
        return cell;
    }
}

- (void)configureRegularCell:(RegularPostTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RegularPost *post = (RegularPost *)self.posts[indexPath.row];
    cell.titleLabel.text = post.title;
    cell.tagsLabel.text = post.tagsString;
    cell.bodyLabel.text = post.body;
    cell.dateLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:post.postedAt]];
}

- (void)configurePhotoCell:(PhotoPostTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoPost *post = (PhotoPost *)self.posts[indexPath.row];
    cell.captionLabel.text = post.caption;
    cell.tagsLabel.text = post.tagsString;
    cell.dateLabel.text = [self.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:post.postedAt]];
    NSString *photoPath = post.photos.firstObject;
    if (photoPath != nil) {
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:photoPath]];
    }
}

#pragma mark - Lazy loaded properties

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        _dateFormatter.dateStyle = NSDateFormatterShortStyle;
        _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    return _dateFormatter;
}

@end

