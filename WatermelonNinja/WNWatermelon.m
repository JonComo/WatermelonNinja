//
//  WNWatermelon.m
//  WatermelonNinja
//
//  Created by Jon Como on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNWatermelon.h"
#import "Constants.h"

@implementation WNWatermelon

+(WNWatermelon *)addToScene:(SKNode *)scene
{
    WNWatermelon *melon = [[WNWatermelon alloc] initWithTexture:[SKTexture textureWithImageNamed:@"melon"]];
    
    melon.xScale = melon.yScale = 0.5;
    
    melon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:melon.size.width*0.4];
    melon.physicsBody.categoryBitMask = watermelonCategory;
    melon.physicsBody.contactTestBitMask = sliceCategory | watermelonCategory | bearCategory;
    melon.physicsBody.collisionBitMask = watermelonCategory;
    melon.physicsBody.usesPreciseCollisionDetection = YES;
    
    [scene addChild:melon];
    
    return melon;
}

@end