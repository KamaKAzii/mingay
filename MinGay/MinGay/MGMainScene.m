//
//  MGMainScene.m
//  MinGay
//
//  Created by Emmet William Rogan on 3/06/2014.
//  Copyright (c) 2014 MG. All rights reserved.
//

#import "MGMainScene.h"
#import "MGWaitingGame.h"

@implementation MGMainScene

/*
 
 Font names in system:
    Lato-Regular
    Lato-Hairline
    Lato-LightItalic
    Lato-Light
 
 */

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createContent];
        self.contentCreated = YES;
    }
}

- (void)createContent
{
    self.backgroundColor = [UIColor whiteColor];
    self.anchorPoint = CGPointMake(0.5, 0.5);
    self.waitingGame = [[MGWaitingGame alloc] init];
    [self addChild:self.waitingGame];
    [self.waitingGame runGameAnimation];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.waitingGame runExitAnimation];
}

@end
