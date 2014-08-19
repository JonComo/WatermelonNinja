//
//  WNBear.m
//  WatermelonNinja
//
//  Created by David de Jesus on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNBear.h"

@implementation WNBear

+(WNBear *)addToScene:(SKNode *)scene
{
    WNBear *bear = [[WNBear alloc] initWithTexture:[SKTexture textureWithImageNamed:@"bear"]];
    
    bear.xScale = bear.yScale = 0.3;
    
    bear.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bear.size.width*0.4];
    bear.physicsBody.allowsRotation = NO;
    bear.physicsBody.mass = 0.3;
    
    [scene addChild:bear];
    
    return bear;
}


@end
