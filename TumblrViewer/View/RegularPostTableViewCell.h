//
//  RegularPostTableViewCell.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HtmlContentHeightDelegate<NSObject>
- (void)didCalculateHeight:(CGFloat)height forHtmlContentId:(NSString*)htmlContentId;
@end

@interface RegularPostTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIWebView *bodyWebView;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) NSString *htmlContentId;
@property (nonatomic, weak) id<HtmlContentHeightDelegate> delegate;
@property (nonatomic, strong) NSLayoutConstraint *webViewHeightConstraint;
@end
