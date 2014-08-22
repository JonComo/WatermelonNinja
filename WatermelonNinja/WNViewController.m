//
//  WNViewController.m
//  WatermelonNinja
//
//  Created by Jon Como on 8/18/14.
//  Copyright (c) 2014 UNMD76. All rights reserved.
//

#import "WNViewController.h"
#import "WNMyScene.h"

@implementation WNViewController
{
    SKView * skView;
    
    BOOL didPlaySong;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newGame) name:@"newGame" object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self newGame];
}

-(void)newGame
{
    // Create and configure the scene.
    SKScene * scene = [WNMyScene sceneWithSize:CGSizeMake(skView.bounds.size.width, skView.bounds.size.height)];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    if (!didPlaySong){
        didPlaySong = YES;
        [scene runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"crazy.m4v" waitForCompletion:YES]]];
    }
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
