//
//  WNGameCompleteScene.m
//  WatermelonNinja
//
//  Created by David de Jesus on 8/19/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNGameCompleteScene.h"

@implementation WNGameCompleteScene
{
    BOOL canRestart;
}

- (id)initWithSize:(CGSize)size playerWon:(BOOL)won score:(int)score
{
    self = [super initWithSize:size];
    if (self) {
        SKSpriteNode *bg = [[SKSpriteNode alloc] initWithImageNamed:@"bg.jpg"];
        bg.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:bg];
        
        // 1
        SKLabelNode* gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        gameOverLabel.fontSize = 42;
        gameOverLabel.position = CGPointMake(size.width/2, size.height/2);
        
        if (won) {
            gameOverLabel.text = @"Game Won";
        } else {
            gameOverLabel.text = @"Game Over";
        }
        
        [self addChild:gameOverLabel];
        
        SKLabelNode* scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        
        scoreLabel.fontSize = 42;
        scoreLabel.position = CGPointMake(size.width/2, size.height/2 - 60);
        
        scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
        
        [self addChild:scoreLabel];
        
        canRestart = NO;
        [self runAction:[SKAction waitForDuration:1] completion:^{
            canRestart = YES;
        }];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!canRestart) return;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"newGame" object:nil];
}

@end
