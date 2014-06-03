//
//  MGAnimations.h
//  MinGay
//
//  Created by Emmet William Rogan on 3/06/2014.
//  Copyright (c) 2014 MG. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MGAnimations : SKNode

@property (strong, nonatomic) NSMutableArray *activeAnimationNodes;

- (void)runCircleAnimation;

@end
