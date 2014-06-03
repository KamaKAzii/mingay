//
//  MGViewController.m
//  MinGay
//
//  Created by Emmet William Rogan on 3/06/2014.
//  Copyright (c) 2014 MG. All rights reserved.
//

#import "MGViewController.h"
#import "MGMainScene.h"
#import <SpriteKit/SpriteKit.h>

@interface MGViewController ()

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    SKView *spriteView = (SKView *) self.view;
    MGMainScene *mainScene = [[MGMainScene alloc] initWithSize:[[UIScreen mainScreen] bounds].size];
    [spriteView presentScene:mainScene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
