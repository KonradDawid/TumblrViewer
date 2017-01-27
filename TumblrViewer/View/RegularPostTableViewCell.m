//
//  RegularPostTableViewCell.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "RegularPostTableViewCell.h"
#import "AppStyle.h"

@interface RegularPostTableViewCell ()
@end

@implementation RegularPostTableViewCell

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
    
    _titleLabel = [AppStyle standardLabel];
    _titleLabel.numberOfLines = 0;
    
    _bodyLabel = [AppStyle standardLabel];
    _bodyLabel.numberOfLines = 0;
    
    _tagsLabel = [AppStyle standardLabel];
    _tagsLabel.numberOfLines = 0;
    
    _dateLabel = [AppStyle standardLabel];
}

- (void)addSubviews {
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_bodyLabel];
    [self.contentView addSubview:_tagsLabel];
    [self.contentView addSubview:_dateLabel];
}

- (void)setupLayout {
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_titleLabel, _bodyLabel, _tagsLabel, _dateLabel);
    
    [self.contentView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-[_bodyLabel]-[_tagsLabel]-[_dateLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bodyLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tagsLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dateLabel]" options:0 metrics:nil views:viewsDictionary]];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.titleLabel.text = @"";
    self.dateLabel.text = @"";
    self.bodyLabel.text = @"";
}

@end

