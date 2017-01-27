//
//  PhotoPostTableViewCell.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "PhotoPostTableViewCell.h"
#import "AppStyle.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PhotoPostTableViewCell ()
@end

@implementation PhotoPostTableViewCell

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
    
    _photoView = [[UIImageView alloc] init];
    _photoView.contentMode = UIViewContentModeScaleAspectFit;
    _photoView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _captionLabel = [AppStyle standardLabel];
    _captionLabel.numberOfLines = 0;
    
    _tagsLabel = [AppStyle standardLabel];
    _tagsLabel.numberOfLines = 0;
    
    _dateLabel = [AppStyle standardLabel];
}

- (void)addSubviews {
    [self.contentView addSubview:_photoView];
    [self.contentView addSubview:_captionLabel];
    [self.contentView addSubview:_tagsLabel];
    [self.contentView addSubview:_dateLabel];
}

- (void)setupLayout {
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_photoView, _captionLabel, _tagsLabel, _dateLabel);
    
    [self.contentView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_photoView(==200)]-[_captionLabel]-[_tagsLabel]-[_dateLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_captionLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tagsLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dateLabel]" options:0 metrics:nil views:viewsDictionary]];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.imageView.image = nil;
    [self.imageView sd_cancelCurrentImageLoad];
    self.tagsLabel.text = @"";
    self.dateLabel.text = @"";
    self.captionLabel.text = @"";
}

@end
