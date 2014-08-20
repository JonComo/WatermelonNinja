//
//  WNGameCompleteScene.m
//  WatermelonNinja
//
//  Created by David de Jesus on 8/19/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNGameCompleteScene.h"

@implementation WNGameCompleteScene

- (id)initWithSize:(CGSize)size playerWon:(BOOL)won
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:0.75 green:0.75 blue:0.65 alpha:1.0];
        
        // 1
        SKLabelNode* gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        gameOverLabel.fontSize = 42;
        gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        if (won) {
            gameOverLabel.text = @"Game Won";
        } else {
            gameOverLabel.text = @"Game Over";
        }
        [self addChild:gameOverLabel];
    }
    return self;
}

@end
