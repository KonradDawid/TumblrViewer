//
//  RegularPostTableViewCell.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegularPostTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end
