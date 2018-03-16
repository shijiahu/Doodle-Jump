//
//  GameView.h
//  DoodleJump
//
//  Created by shijia hu on 2/18/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Jumper.h"
#import "Brick.h"

@interface GameView : UIView

@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic, strong) NSMutableArray *orangebricks;
@property (nonatomic) float tilt;
@property (nonatomic) int count;
@property (nonatomic, strong) IBOutlet UILabel *Score;
@property (nonatomic, strong) IBOutlet UILabel * GameOver;

-(void)arrange:(CADisplayLink *)sender;
-(void)createBricks:(NSMutableArray *)bricks1 with: (UIImage *)image;
-(void)removeBricks:(Brick *)brick with: (NSMutableArray *)bricks1;

@end




