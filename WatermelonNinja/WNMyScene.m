//
//  WNMyScene.m
//  WatermelonNinja
//
//  Created by Jon Como on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNMyScene.h"

#import "WNWatermelon.h"

#import "WNBear.h"

#import "JCMath.h"

#import "Constants.h"

@interface WNMyScene () <SKPhysicsContactDelegate>{
    
}

@end

@implementation WNMyScene
{
    int timeUntilThrow;
    
    NSMutableArray *melons;
    NSMutableArray *bears;
    NSMutableArray *effects;
    
    CGPoint touchLocation;
    CGPoint lastTouch;
    SKSpriteNode *slashNode;
    
    BOOL isSlashing;
    
    float slashPower;
    
    SKNode *world;
    
    int screenShake;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        world = [SKNode node];
        [self addChild:world];
        
        self.physicsWorld.gravity = CGVectorMake(0, -4);
        
        melons = [NSMutableArray array];
        effects = [NSMutableArray array];
        bears = [NSMutableArray array];
        
        timeUntilThrow = 20;
        screenShake = 0;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        slashNode = [[SKSpriteNode alloc] initWithColor:[UIColor whiteColor] size:CGSizeMake(100, 10)];
        slashNode.position = CGPointMake(size.width/2, size.height/2);
        slashNode.alpha = 0;
        [self addChild:slashNode];
        
        self.physicsWorld.contactDelegate = self;
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isSlashing = YES;
    
    touchLocation = [[touches anyObject] locationInNode:self];
    lastTouch = touchLocation;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchLocation = [[touches anyObject] locationInNode:self];
    
    slashPower = sqrt(pow(touchLocation.x - lastTouch.x, 2) + pow(touchLocation.y - lastTouch.y, 2))/100;
    
    slashNode.position = touchLocation;
    slashNode.alpha = slashPower;
    slashNode.zRotation = [JCMath angleFromPoint:lastTouch toPoint:touchLocation];
    
    lastTouch = touchLocation;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    slashNode.alpha = 0;
    isSlashing = NO;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if (screenShake > 0){
        world.position = CGPointMake((float)(arc4random()%screenShake), (float)(arc4random()%screenShake));
        screenShake--;
    }else{
        world.position = CGPointMake(0, 0);
    }
    
    if (timeUntilThrow < 0){
        timeUntilThrow += 60;
        //throw a watermelon out!
        
        WNWatermelon *melon = [WNWatermelon addToScene:world];
        melon.position = CGPointMake(arc4random()%(int)self.size.width, -melon.size.height/2);
        
        [melon.physicsBody applyImpulse:CGVectorMake((float)(arc4random()%20) - 10.0f, arc4random()%100 + 100)];
        [melon.physicsBody applyAngularImpulse:((float)(arc4random()%10) - 5.0f)/40.0f];

        [self runAction:[SKAction playSoundFileNamed:@"thoop.wav" waitForCompletion:NO]];

        [melons addObject:melon];
        
        WNBear *bear = [WNBear addToScene:world];
    
        bear.position = CGPointMake(arc4random()%(int)self.size.width, -bear.size.height/2);
        
        [bear.physicsBody applyImpulse:CGVectorMake((float)(arc4random()%20) - 10.0f, arc4random()%100 + 100)];
        [bear.physicsBody applyAngularImpulse:((float)(arc4random()%10) - 5.0f)/40.0f];

        [bears addObject:bear];
    }else{
        timeUntilThrow --;
    }
    
    for (int j = bears.count-1; j>0; j--) {
        WNBear *aBear = bears[j];
        if (aBear.position.x < aBear.size.width/2){
            aBear.position = CGPointMake(aBear.size.width/2, aBear.position.y);
        }else if (aBear.position.x > self.size.width - aBear.size.width/2){
            aBear.position = CGPointMake(self.size.width - aBear.size.width/2, aBear.position.y);
        }
        
        if (aBear.position.y < -100 || aBear.position.y > 400){
            //Fell out of world
            [aBear removeFromParent];
            [bears removeObject:aBear];
        }
        if (isSlashing && slashPower > 0.2 && [JCMath distanceBetweenPoint:touchLocation andPoint:aBear.position sorting:NO] < aBear.size.width){
            //Slashed a melon!!
            [aBear removeFromParent];
            [bears removeObject:aBear];
            [self addDeadBearToPoint:aBear.position];
            [self addParticlesToPoint:aBear.position];
            
            [self runAction:[SKAction playSoundFileNamed:@"splat.wav" waitForCompletion:NO]];
            
            screenShake += 8;
        }
        
    }
    
    for (int i = melons.count-1; i>0; i--){
        WNWatermelon *melon = melons[i];
        
        if (melon.position.x < melon.size.width/2){
            melon.position = CGPointMake(melon.size.width/2, melon.position.y);
        }else if (melon.position.x > self.size.width - melon.size.width/2){
            melon.position = CGPointMake(self.size.width - melon.size.width/2, melon.position.y);
        }
        
        if (melon.position.y < -100){
            //Fell out of world
            [melon removeFromParent];
            [melons removeObject:melon];
        }
        
        if (isSlashing && slashPower > 0.2 && [JCMath distanceBetweenPoint:touchLocation andPoint:melon.position sorting:NO] < melon.size.width){
            //Slashed a melon!!
            [melon removeFromParent];
            [melons removeObject:melon];
            
            [self addSlicesToPoint:melon.position];
            [self addSlicesToPoint:melon.position];
            
            [self addParticlesToPoint:melon.position];
            
            [self runAction:[SKAction playSoundFileNamed:@"splat.wav" waitForCompletion:NO]];
            
            screenShake += 8;
        }
    }
    
    //for slices and particles
    for (int i = effects.count-1; i>0; i--){
        SKSpriteNode *node = effects[i];
        
        if (node.position.y < -100){
            [effects removeObject:node];
            [node removeFromParent];
        }
    }
}

-(void)addSlicesToPoint:(CGPoint)point
{
    SKSpriteNode *slice = [[SKSpriteNode alloc] initWithImageNamed:@"melonSlice"];
    slice.position = CGPointMake(point.x + (float)(arc4random()%40) -20.0f, point.y + (float)(arc4random()%40) -20.0f);
    slice.xScale = slice.yScale = 0.5;
    
    [world addChild:slice];
    
    slice.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:slice.size.width*0.3];
    slice.physicsBody.mass = 0.1;
    slice.physicsBody.categoryBitMask = sliceCategory;
    slice.physicsBody.collisionBitMask = 0;
    slice.physicsBody.contactTestBitMask = watermelonCategory|bearCategory|worldCategory;

    
    [slice.physicsBody applyImpulse:CGVectorMake((float)(arc4random()%100) - 50.0f, (float)(arc4random()%100) - 50.0f)];
    [slice.physicsBody applyAngularImpulse:((float)(arc4random()%10) - 5.0f)/200.0f];
    
    [effects addObject:slice];
}

-(void)addParticlesToPoint:(CGPoint)point
{
    SKEmitterNode *particles = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"juiceParticles" ofType:@"sks"]];
    [self addChild:particles];
    particles.position = point;
    
    __weak SKEmitterNode *weakRef = particles;
    
    [self runAction:[SKAction waitForDuration:2] completion:^{
        [weakRef removeFromParent];
    }];
}

- (void)addDeadBearToPoint:(CGPoint)point
{
    SKSpriteNode *xbear = [[SKSpriteNode alloc] initWithImageNamed:@"xbear"];
    xbear.position = CGPointMake(point.x + (float)(arc4random()%40) -20.0f, point.y + (float)(arc4random()%40) -20.0f);
    xbear.xScale = xbear.yScale = 0.3;
    
    [world addChild:xbear];
    
    xbear.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:xbear.size.width*0.3];
    xbear.physicsBody.mass = 0.1;
    xbear.physicsBody.categoryBitMask = bearCategory;
    xbear.physicsBody.collisionBitMask = 0;
    xbear.physicsBody.contactTestBitMask = watermelonCategory|bearCategory|worldCategory;
    
    
    [xbear.physicsBody applyImpulse:CGVectorMake((float)(arc4random()%100) - 50.0f, (float)(arc4random()%100) - 50.0f)];
    [xbear.physicsBody applyAngularImpulse:((float)(arc4random()%10) - 5.0f)/200.0f];
    
    [effects addObject:xbear];
    
}

@end
