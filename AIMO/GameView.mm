//
//  GameView.m
//  AIMO
//
//  Created by M on 1/27/13.
//
//

#import "GameView.h"
#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>



@interface GameView ()
@end

@implementation GameView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
//    ViewController* vc = (ViewController*) self.viewController;
//    
//    NSTimeInterval currentCallTime = [vc.displayLink timestamp];
//    float timeInterval = currentCallTime - vc.lastCallTime;
//    vc.lastCallTime = currentCallTime;
//    
//    //NSLog(@"Time since last call: %e", timeInterval);



    self.gameWorld->render();

//    static int g = 1;
//    g++;
//    g = g%100;
//    
//    UIColor *color = [UIColor colorWithRed:2-g/50 green:g/200.0 blue:1-g/200.0 alpha:1];
//    
//    [GameView drawCircleWithPosition:Vector2D(20,55) withSize:20 andColor:color];
}

+(void)drawCircleWithPosition:(Vector2D) pos
                     withSize:(CGFloat) size
                     andColor:(UIColor*) color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextSetLineWidth(context, 4.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGRect rectangle = CGRectMake(pos.x - size/2, pos.y - size/2, size, size);
    
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, rectangle);
    CGContextDrawPath(context, kCGPathFill); // kCGPathFillStroke Or kCGPathFill
}

+(void)drawPolygons:(std::vector<Vector2D> &)points
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    for(int i=0; i < points.size(); i++)
    {
        Vector2D point = points[i];
        if(i)
        {
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        else
        {
            // move to the first point
            CGContextMoveToPoint(context, point.x, point.y);
        }
    }
    
    CGContextStrokePath(context);
}
@end
