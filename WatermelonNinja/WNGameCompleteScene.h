//
//  WNGameCompleteScene.h
//  WatermelonNinja
//
//  Created by David de Jesus on 8/19/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WNGameCompleteScene : SKScene

- (id)initWithSize:(CGSize)size playerWon:(BOOL)won score:(int)score;

@end
