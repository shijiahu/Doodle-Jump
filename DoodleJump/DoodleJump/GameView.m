//
//  GameView.m
//  DoodleJump
//
//  Created by shijia hu on 2/18/17.
//  Copyright © 2017 shijia hu. All rights reserved.
//

#import "GameView.h"

@implementation GameView
@synthesize jumper, bricks,orangebricks;
@synthesize tilt;
@synthesize count;
@synthesize Score;
@synthesize GameOver;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CGRect bounds = [self bounds];
        
        UIImage *image = [UIImage imageNamed:@"doodle2.jpeg"];
        jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height - 20, 30, 30)];
        [jumper setDx:0];
        [jumper setDy:10];
        jumper.image = image;
        [self addSubview:jumper];
        [self makeBricks:nil];
        Score.text = @"0";
    }
    return self;
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//    }
//    return self;
//}

-(IBAction)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    count = 0;
    Score.text = @"0";
    GameOver.text = @"";
//    jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height - 20, 30, 30)];
    [jumper setDx:0];
    [jumper setDy:10];
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    if (orangebricks) {
        for (Brick *brick in orangebricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    
    orangebricks = [[NSMutableArray alloc] init];
    
    UIImage *imageimage = [UIImage imageNamed:@"doodle4.jpeg"];
    UIImageView *imageimageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(0, 0, width, height) ];
    imageimageView.image = imageimage;
    [orangebricks addObject:imageimageView];
    
    for (int i = 0; i < 10; ++i)
    {
        int flag = 0;
        //Brick *b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        
        UIImage *image = [UIImage imageNamed:@"doodle3.jpeg"];
        
        //[image drawInRect:CGRectMake(60, 340, 20, 20)];//draw in rect

        // create UIImageView
        UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(0, 0, width, height) ];
        imageView.image = image;
        [self addSubview:imageView];
        
        [imageView setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)(bounds.size.height * .8))];
        if (i == 0) {
            [bricks addObject:imageView];
        }else{
            while (flag != 1) {
                for (Brick *brick in bricks) {
                    if ((width*width + 400) >= ((imageView.center.x - brick.center.x)*(imageView.center.x - brick.center.x)+(imageView.center.y - brick.center.y)*(imageView.center.y - brick.center.y))) {
                        [imageView setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)(bounds.size.height * .8))];
                        break;
                    }
                    if ([brick isEqual:bricks.lastObject]) {
                        flag = 1;
                        [bricks addObject:imageView];
                    }
                }
            }
            
        }
    }
}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
// - (void)drawRect:(CGRect)rect {
// // Drawing code

// }


-(void)createBricks:(NSMutableArray *)bricks1 with: (UIImage *)image
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    
    for (int i = 0; i < 2; ++i)
    {
        int flag = 0;
       // UIImage *image = [UIImage imageNamed:@"doodle3.jpeg"];
        UIImageView *imageView = [ [ UIImageView alloc ] initWithFrame:CGRectMake(0, 0, width, height)];
        imageView.image = image;
        [self addSubview:imageView];
        [imageView setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)(bounds.size.height/2.0 + 1.0))];
        //if (bricks1) {
            while (flag != 1) {
                for (Brick *brick in bricks1) {
                    if ((width*width + 400) >= ((imageView.center.x - brick.center.x)*(imageView.center.x - brick.center.x)+(imageView.center.y - brick.center.y)*(imageView.center.y - brick.center.y))) {
                        [imageView setCenter:CGPointMake(rand() % (int)(bounds.size.width * .8), rand() % (int)(bounds.size.height/2.0 + 1.0))];
                        break;
                    }
                    if ([brick isEqual:bricks1.lastObject]) {
                        flag = 1;
                        [bricks1 addObject:imageView];
                    }
                }
            }
    }

}

-(void)removeBricks:(Brick *)brick with: (NSMutableArray *)bricks1
{
    //brick disaper+++++++++++
    [brick removeFromSuperview];
    NSMutableArray  *bArr = [bricks1 mutableCopy];
    bricks1 = nil;
    
    int  i = 0;
    while(bArr.count>i)
    {
        NSObject * itemObject =  [bArr objectAtIndex:i];
        if([itemObject isEqual:brick])
        {
            [bArr removeObject:itemObject]; //释放
            itemObject = nil;
        }else{
            i++;
        }
    }
    bricks1 = bArr;
}

-(void)arrange:(CADisplayLink *)sender
{
    
    CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
    // Apply the tilt.  Limit maximum tilt to + or - 5
    [jumper setDx:[jumper dx] + tilt];
    if ([jumper dx] > 5)
        [jumper setDx:5];
    if ([jumper dx] < -5)
        [jumper setDx:-5];
    
    // Jumper moves in the direction of gravity
    
    CGPoint p = [jumper center];
    
    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    // If the jumper has fallen below the bottom of the screen,
    // add a positive velocity to move him
    if (p.y > bounds.size.height)
    {
        GameOver.text = @"Game Over";
        
        [jumper setDx:0];
        [jumper setDy:0];
        p.y = bounds.size.height;
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < 0)
        p.y += bounds.size.height/2;
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
        p.x += bounds.size.width;
    if (p.x > bounds.size.width)
        p.x -= bounds.size.width;
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
            if (CGRectContainsPoint(b, p))
            {
                // Yay!  Bounce!
                [Score setText:[NSString stringWithFormat: @"%d",[Score.text intValue]+10]];
                NSLog(@"Bounce!");
                [jumper setDy:10];
                
                //remove bricks if it go downside of the bounds
                NSMutableArray  *aArr = [bricks mutableCopy];
                bricks = nil;
                
                for (Brick *brick1 in aArr) {
                    [brick1 setCenter:CGPointMake(brick1.center.x, brick1.center.y + 100)];
                    
                    //if brick down to bounds, remove it from bricks
                    if (brick1.center.y > bounds.size.height) {
                        [self removeBricks:brick1 with:aArr];
                        
                    }
                }
                bricks = aArr;
                
                NSMutableArray  *bArr = [orangebricks mutableCopy];
                orangebricks = nil;
                for (Brick *brick3 in bArr) {
                    [brick3 setCenter:CGPointMake(brick3.center.x, brick3.center.y + 100)];
                    if (brick3.center.y > bounds.size.height) {
                        [self removeBricks:brick3 with:bArr];
                        
                    }
                }
                orangebricks = bArr;
                
                
                count ++;
                
                if (count%10 == 0) {
                    
                    UIImage *image1 = [UIImage imageNamed:@"doodle4.jpeg"];
                    [self createBricks:orangebricks with:image1];
                    
                }else{
                    UIImage *image1 = [UIImage imageNamed:@"doodle3.jpeg"];
                    [self createBricks:bricks with:image1];
                }
            }
        }
        
        for (Brick *brick2 in orangebricks) {
            CGRect b2 = [brick2 frame];
            if (CGRectContainsPoint(b2, p))
            {
                NSLog(@"Bounce!But Dispear!");
                [Score setText:[NSString stringWithFormat: @"%d",[Score.text intValue]+20]];
                [jumper setDy:5];
                [brick2 removeFromSuperview];
                [self removeBricks:brick2 with:orangebricks];
                
                break;
                
            }
        }
    }
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}

@end
