//
//  WNMyScene.m
//  WatermelonNinja
//
//  Created by Jon Como on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNMyScene.h"

#import "WNWatermelon.h"

@implementation WNMyScene
{
    int timeUntilThrow;
    NSMutableArray *melons;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        melons = [NSMutableArray array];
        timeUntilThrow = 20;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
    }
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
