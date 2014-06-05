//
//  MGMainScene.h
//  MinGay
//
//  Created by Emmet William Rogan on 3/06/2014.
//  Copyright (c) 2014 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MGWaitingGame.h"

@interface MGMainScene : SKScene

@property BOOL contentCreated;

@property (strong, nonatomic) MGWaitingGame *waitingGame;

@end
