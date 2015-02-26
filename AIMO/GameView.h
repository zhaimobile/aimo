//
//  GameView.h
//  AIMO
//
//  Created by M on 1/27/13.
//
//

#import <UIKit/UIKit.h>

//c++ header
#import "Vector2D.h"
#import "GameWorld.h"

@interface GameView : UIView

// This will break MVC; however it is her just 
@property (nonatomic, strong) UIViewController * viewController;

@property (atomic) GameWorld * gameWorld;


+(void)drawCircleWithPosition:(Vector2D) pos
                     withSize:(CGFloat) size
                     andColor:(UIColor*) color;

+(void)drawPolygons:(std::vector<Vector2D> &)points;


@end
