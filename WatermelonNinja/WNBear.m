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
    
    bear.xScale = bear.yScale = 0.35;
    
    bear.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:bear.size.width*0.4];
    
    
    [scene addChild:bear];
    
    return bear;
}


@end
