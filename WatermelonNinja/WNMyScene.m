//
//  WNMyScene.m
//  WatermelonNinja
//
//  Created by Jon Como on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNMyScene.h"

#import "WNWatermelon.h"

#import "JCMath.h"

@implementation WNMyScene
{
    int timeUntilThrow;
    NSMutableArray *melons;
    
    CGPoint lastTouch;
    SKSpriteNode *slashNode;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        melons = [NSMutableArray array];
        timeUntilThrow = 20;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        slashNode = [[SKSpriteNode alloc] initWithColor:[UIColor whiteColor] size:CGSizeMake(100, 10)];
        slashNode.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:slashNode];
        
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInNode:self];
    
    slashNode.position = location;
    slashNode.alpha = sqrt(pow(location.x - lastTouch.x, 2) + pow(location.y - lastTouch.y, 2))/100;
    slashNode.zRotation = [JCMath angleFromPoint:lastTouch toPoint:location];
    
    lastTouch = location;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    slashNode.alpha = 0;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (timeUntilThrow < 0){
        timeUntilThrow += 20;
        //throw a watermelon out!
        
        WNWatermelon *melon = [WNWatermelon addToScene:self];
        melon.position = CGPointMake(arc4random()%(int)self.size.width, -melon.size.height/2);
        
        [melon.physicsBody applyImpulse:CGVectorMake((float)(arc4random()%20) - 10.0f, arc4random()%200 + 200)];
        [melon.physicsBody applyAngularImpulse:((float)(arc4random()%10) - 5.0f)/20.0f];
        
        [melons addObject:melon];
    }else{
        timeUntilThrow --;
    }
    
    for (int i = melons.count-1; i>0; i--){
        WNWatermelon *melon = melons[i];
        if (melon.position.y < -100){
            //Fell out of world
            [melon removeFromParent];
            [melons removeObject:melon];
        }
    }
}

@end
