//
//  ViewController.m
//  AIMO
//
//  Created by M on 1/26/13.
//
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "GameView.h"
#import "GameWorld.h"

@interface ViewController ()
@property (atomic, strong) CADisplayLink *displayLink;
@property (atomic) GameWorld * gameWorld;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //Create CADisplayLink and add updat selector for game loop
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameLoop)];
    
    // Notify the application at the refresh rate of the display (60 Hz)
    self.displayLink.frameInterval = 1;
    
    self.lastCallTime = 0;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.gameWorld = new GameWorld(self.view.bounds.size.width, self.view.bounds.size.height);
    
    GameView * gv = (GameView*)self.view;
    gv.viewController = self;
    gv.gameWorld = self.gameWorld;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gameLoop
{
    if(!self.lastCallTime){self.lastCallTime = [self.displayLink  timestamp]; return;}
    
    NSTimeInterval currentCallTime = [self.displayLink  timestamp];
    NSTimeInterval timeInterval = currentCallTime - self.lastCallTime;
    self.lastCallTime = currentCallTime;
    
    //NSLog(@"Time since last call: %e", timeInterval);

    //doing update
    self.gameWorld->update(timeInterval);
    
    [self.view setNeedsDisplay];
}
- (IBAction)touchPoint:(UITapGestureRecognizer *)sender {
    
    CGPoint tapPoint = [sender locationInView:self.view];
    //CGPoint tapPointInView = [myScrollView convertPoint:tapPoint toView:self.view];
    self.gameWorld->SetCrosshair(Vector2D(tapPoint.x, tapPoint.y));
    
    return;
}

@end