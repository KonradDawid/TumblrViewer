//
//  ViewController.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "MainViewController.h"
#import "PostsTableViewController.h"
#import "SearchViewController.h"
#import "TumblrClient.h"
#import "Post.h"
#import "TumblrInfo.h"

@interface MainViewController () <PageRequestDelegate>
@property (nonatomic, strong) PostsTableViewController* postsTableViewController;
@property (nonatomic, strong) SearchViewController *searchViewController;
@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    if (self = [super initWithNibName:nibName bundle:nibBundle]) {
        
        _searchViewController = [[SearchViewController alloc] initWithNibName:nil bundle:nil];
        _searchViewController.delegate = self;
        _postsTableViewController = [[PostsTableViewController alloc] initWithNibName:nil bundle:nil];
        _postsTableViewController.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    [self setupLayout];
}

- (void)addChildViewControllers {
    
    self.searchViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.postsTableViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addChildViewController:self.searchViewController];
    [self addChildViewController:self.postsTableViewController];
    
    [self.view addSubview:self.searchViewController.view];
    [self.view addSubview:self.postsTableViewController.view];
    
    [self.searchViewController didMoveToParentViewController:self];
    [self.postsTableViewController didMoveToParentViewController:self];
}

- (void)setupLayout {
    
    NSDictionary* viewsDictionary = @{ @"topLayoutGuide" : self.topLayoutGuide, @"_searchVCView" : self.searchViewController.view, @"_tableVCView" : self.postsTableViewController.view };
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-[_searchVCView]-[_tableVCView]-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_searchVCView]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableVCView]|" options:0 metrics:nil views:viewsDictionary]];
}

#pragma mark - PageRequestDelegate

- (void)didRequestNextPageWithInfo:(BOOL)info offset:(NSUInteger)offset {
    
    [[TumblrClient sharedClient] getPostsForUsername:self.searchViewController.searchBar.text withInfo:info offset:offset success:^(NSArray<Post *>* posts, TumblrInfo *info) {
        
        [self.postsTableViewController appendNewPosts:posts offset:offset info:info];
        if (info) {
            self.title = info.title;
        }
        
    } andFailure:^(NSError *error) {
        [self.postsTableViewController showError];
        self.title = @"";
    }];
}

@end

