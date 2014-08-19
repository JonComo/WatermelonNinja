//
//  WNWatermelon.m
//  WatermelonNinja
//
//  Created by Jon Como on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNWatermelon.h"

@implementation WNWatermelon

+(WNWatermelon *)addToScene:(SKScene *)scene
{
    WNWatermelon *melon = [[WNWatermelon alloc] initWithTexture:[SKTexture textureWithImageNamed:@"melon"]];
    
    melon.xScale = melon.yScale = 0.5;
    
    melon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:melon.size.width/2];
    
    
    [scene addChild:melon];
    
    return melon;
}

@end