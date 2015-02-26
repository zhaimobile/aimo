//
//  ViewController.h
//  AIMO
//
//  Created by M on 1/26/13.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (atomic, strong, readonly) CADisplayLink *displayLink;
@property (atomic) NSTimeInterval lastCallTime;
@end