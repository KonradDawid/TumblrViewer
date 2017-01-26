//
//  ErrorView.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "ErrorView.h"
#import "AppStyle.h"

@interface ErrorView()
@property (nonatomic, strong) UILabel *errorLabel;
@end

@implementation ErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
        [self addSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupView {
    _errorLabel = [AppStyle standardLabel];
    _errorLabel.textColor = [UIColor redColor];
    _errorLabel.text = @"Error. Try again...";
}

- (void)addSubviews {
    [self addSubview:_errorLabel];
}

- (void)setupLayout {
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_errorLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_errorLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-100]];
}

@end
