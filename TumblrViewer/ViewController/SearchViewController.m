//
//  SearchViewController.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () < UISearchBarDelegate>
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.searchBar];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_searchBar);
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_searchBar]-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_searchBar]|" options:0 metrics:nil views:viewsDictionary]];
}

#pragma mark - UISearchBar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(requestFirstPage) object:nil];
    [self performSelector:@selector(requestFirstPage) withObject:nil afterDelay:0.5];
}

- (void)requestFirstPage {
    if ([self.delegate respondsToSelector:@selector(didRequestNextPageWithInfo:offset:)]) {
        [self.delegate didRequestNextPageWithInfo:YES offset:0];
    }
}

#pragma mark - Lazy loaded properties

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
        _searchBar.translatesAutoresizingMaskIntoConstraints = NO;
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end

