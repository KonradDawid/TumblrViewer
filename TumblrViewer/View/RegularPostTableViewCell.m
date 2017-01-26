//
//  RegularPostTableViewCell.m
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import "RegularPostTableViewCell.h"
#import "AppStyle.h"

@interface RegularPostTableViewCell () <UIWebViewDelegate>
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
    
    _bodyWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    _bodyWebView.scrollView.bounces = NO;
    _bodyWebView.translatesAutoresizingMaskIntoConstraints = NO;
    _bodyWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    _bodyWebView.userInteractionEnabled = NO;
    _bodyWebView.delegate = self;
    
    _tagsLabel = [AppStyle standardLabel];
    _tagsLabel.numberOfLines = 0;
    
    _dateLabel = [AppStyle standardLabel];
}

- (void)addSubviews {
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_bodyWebView];
    [self.contentView addSubview:_tagsLabel];
    [self.contentView addSubview:_dateLabel];
}

- (void)setupLayout {
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_titleLabel, _bodyWebView, _tagsLabel, _dateLabel);
    
    [self.contentView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_titleLabel]-[_bodyWebView]-[_tagsLabel]-[_dateLabel]-20-|" options:0 metrics:nil views:viewsDictionary]];
    
    self.webViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_bodyWebView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
    self.webViewHeightConstraint.priority = UILayoutPriorityDefaultLow;
    [self.contentView addConstraint:self.webViewHeightConstraint];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLabel]-|" options:0 metrics:nil views:viewsDictionary]];
    
    [self.contentView addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_bodyWebView]-5-|" options:0 metrics:nil views:viewsDictionary]];
    
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
    
    self.titleLabel.text = @"";
    self.dateLabel.text = @"";
    [self.bodyWebView stopLoading];
}

@end

