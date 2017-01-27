//
//  PhotoPostTableViewCell.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegularPostTableViewCell.h"

@interface PhotoPostTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) UILabel *captionLabel;
@property (nonatomic, strong) UILabel *tagsLabel;
@property (nonatomic, strong) UILabel *dateLabel;;
@end
