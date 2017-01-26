//
//  SearchViewController.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface SearchViewController : UIViewController
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, weak) id<PageRequestDelegate> delegate;
@end
