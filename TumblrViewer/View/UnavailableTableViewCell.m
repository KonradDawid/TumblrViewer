//
//  UnavailableTableViewCell.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "UnavailableTableViewCell.h"
#import "AppStyle.h"

@interface UnavailableTableViewCell ()
@property (nonatomic, strong) UILabel *postLabel;
@end

@implementation UnavailableTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupView];
        [self addSubviews];
        [self setupLayout];
    }
    return self;
}

- (void)setupView {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _postLabel = [AppStyle standardLabel];
    _postLabel.textColor = [UIColor redColor];
    _postLabel.text = @"Content not available";
}

- (void)addSubviews {
    [self.contentView addSubview:_postLabel];
}

- (void)setupLayout {
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_postLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_postLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
}

@end
