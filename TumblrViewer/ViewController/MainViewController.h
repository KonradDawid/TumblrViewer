//
//  ViewController.h
//  TumblrViewer
//
//  Created by Konrad on 26.01.2017.
//  Copyright © 2017 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageRequestDelegate<NSObject>
- (void)didRequestNextPageWithInfo:(BOOL)info offset:(NSUInteger)offset;
@end

@interface MainViewController : UIViewController
@end


