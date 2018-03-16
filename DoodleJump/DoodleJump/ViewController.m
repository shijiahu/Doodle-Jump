//
//  ViewController.m
//  DoodleJump
//
//  Created by shijia hu on 2/16/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//


#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    //[_displayLink setPreferredFramesPerSecond:30];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    
    
    //_gameView = [[GameView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    //_gameView.backgroundColor = [UIColor clearColor];
    //[self.view addSubview:_gameView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)speedChange:(id)sender
{
    UISlider *s = (UISlider *)sender;
    // NSLog(@"tilt %f", (float)[s value]);
    [_gameView setTilt:(float)[s value]];
}

@end
