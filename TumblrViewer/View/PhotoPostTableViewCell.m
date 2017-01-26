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

@interface PhotoPostTableViewCell () <UIWebViewDelegate>
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
    
    _captionWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    _captionWebView.translatesAutoresizingMaskIntoConstraints = NO;
    _captionWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    _captionWebView.userInteractionEnabled = NO;
    _captionWebView.delegate = self;
    
    _tagsLabel = [AppStyle standardLabel];
    _tagsLabel.numberOfLines = 0;
    
    _dateLabel = [AppStyle standardLabel];
}

- (void)addSubviews {
    [self.contentView addSubview:_photoView];
    [self.contentView addSubview:_captionWebView];
    [self.contentView addSubview:_tagsLabel];
    [self.contentView addSubview:_dateLabel];
}

- (void)setupLayout {
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_photoView, _captionWebView, _tagsLabel, _dateLabel);
    
    [self.contentView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_photoView(==200)]-[_captionWebView]-[_tagsLabel]-[_dateLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    
    self.webViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_captionWebView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    self.webViewHeightConstraint.priority = UILayoutPriorityDefaultLow;
    [self.contentView addConstraint:self.webViewHeightConstraint];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_captionWebView]-5-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_photoView]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tagsLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_dateLabel]" options:0 metrics:nil views:viewsDictionary]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *scrollHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight;"];
    if ([self.delegate respondsToSelector:@selector(didCalculateHeight:forHtmlContentId:)]) {
        [self.delegate didCalculateHeight:[scrollHeight floatValue] forHtmlContentId:self.htmlContentId];
    }
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.imageView.image = nil;
    [self.imageView sd_cancelCurrentImageLoad];
    self.tagsLabel.text = @"";
    self.dateLabel.text = @"";
    [self.captionWebView stopLoading];
}

@end
