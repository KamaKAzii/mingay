//
//  MGAnimations.m
//  MinGay
//
//  Created by Emmet William Rogan on 3/06/2014.
//  Copyright (c) 2014 MG. All rights reserved.
//

#import "MGWaitingGame.h"
#import "SKTUtils.h"
#import "SKTEffects.h"
#import "SKAction+SKTExtras.h"
#import "SKAction+SKTSpecialEffects.h"
#import "SKNode+SKTExtras.h"
#import "SKNode+SKTDebugDraw.h"

@implementation MGWaitingGame

- (id)init
{
    if (self = [super init])
    {
        self.activeAnimationNodes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)runGameAnimation
{
    [self runListenLabelEntryAnimations];
    [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(runCircleEntryAnimations) userInfo:nil repeats:NO];
}

- (void)runListenLabelEntryAnimations
{
    self.activeLabelNodes = [[NSMutableArray alloc] init];
    self.activeLabelNodesContainer = [[SKNode alloc] init];
    
    NSArray *letters          = @[@"l", @"i", @"s", @"t", @"e", @"n"];
    NSArray *letterXs         = @[@6, @8, @10, @10, @13, @0];
    
    SKLabelNode *tempLabel = [[SKLabelNode alloc] initWithFontNamed:@"Lato-Light"];
    tempLabel.fontColor = [UIColor blackColor];
    tempLabel.alpha = 0;
    tempLabel.fontSize = 25;

    int x = 0;
    for (int i = 0; i < letters.count; i++)
    {
        SKLabelNode *label = tempLabel.copy;
        label.position = CGPointMake(x, 260);
        label.text = [letters objectAtIndex:i];
        [self.activeLabelNodes addObject:label];
        [self.activeLabelNodesContainer addChild:label];
        x = x + [[letterXs objectAtIndex:i] intValue];
    }
    [self addChild:self.activeLabelNodesContainer];
    float containerWidth = [self.activeLabelNodesContainer calculateAccumulatedFrame].size.width;
    self.activeLabelNodesContainer.position = CGPointMake((-containerWidth / 2) + 5, -10); // ???
    
    for (int i = 0; i < self.activeLabelNodes.count; i++)
    {
        float animationDuration = 4;
        SKLabelNode *label = [self.activeLabelNodes objectAtIndex:i];
        
        SKAction *actionWait = [SKAction waitForDuration:0.5 * i];
        SKAction *actionFadeIn = [SKAction fadeAlphaTo:0.2 duration:animationDuration];
        SKTMoveEffect *effectMove = [SKTMoveEffect effectWithNode:label
                                                         duration:animationDuration
                                                    startPosition:label.position
                                                      endPosition:CGPointMake(label.position.x, label.position.y - 260)];
        
        effectMove.timingFunction = SKTTimingFunctionBackEaseInOut;
        SKAction *actionMove = [SKAction actionWithEffect:effectMove];
        SKAction *actionGroup = [SKAction group:@[actionFadeIn, actionMove]];
        SKAction *actionSequence = [SKAction sequence:@[actionWait, actionGroup]];
        
        [label runAction:actionSequence];
    }
}

- (void)runCircleEntryAnimations
{
    int numberOfCircles = 4;
    int startingDiameter = 70;
    
    for (int i = 0; i < numberOfCircles; i++) {
        SKShapeNode *circle = [[SKShapeNode alloc] init];
        
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddArc(circlePath, NULL, 0, 0, startingDiameter * (i + 1), 0, M_PI * 2, YES);
        circle.path = circlePath;
        circle.alpha = 0;
        circle.xScale = 1;
        circle.yScale = 1;
        circle.fillColor = [UIColor blackColor];
        
        [self addChild:circle];
        [self.activeAnimationNodes addObject:circle];
    }
    
    for (int i = 0; i < self.activeAnimationNodes.count; i++)
    {
        SKShapeNode *circle = [self.activeAnimationNodes objectAtIndex:i];
        
        SKAction *actionFadeIn = [SKAction fadeAlphaTo:0.04 duration:0.5];
        SKAction *actionWait = [SKAction waitForDuration:i * 0.5];
        SKTScaleEffect *effectScale = [SKTScaleEffect effectWithNode:circle
                                                            duration:3
                                                          startScale:CGPointMake(0.01, 0.01)
                                                            endScale:CGPointMake(1, 1)];
        
        effectScale.timingFunction = SKTTimingFunctionQuarticEaseInOut;
        SKAction *actionScaleUp = [SKAction actionWithEffect:effectScale];
        SKTScaleEffect *effectScaleDownSmall = [SKTScaleEffect effectWithNode:circle
                                                                     duration:3
                                                                   startScale:CGPointMake(1, 1) endScale:CGPointMake(0.8, 0.8)];
        
        effectScaleDownSmall.timingFunction = SKTTimingFunctionCubicEaseInOut;
        SKTScaleEffect *effectScaleUpSmall = [SKTScaleEffect effectWithNode:circle
                                                                   duration:4
                                                                 startScale:CGPointMake(1, 1)
                                                                   endScale:CGPointMake(1.2, 1.2)];
        
        effectScaleUpSmall.timingFunction = SKTTimingFunctionCubicEaseInOut;
        SKAction *actionScaleDownSmall = [SKAction actionWithEffect:effectScaleDownSmall];
        SKAction *actionScaleUpSmall = [SKAction actionWithEffect:effectScaleUpSmall];
        
        SKAction *actionScalingSequence = [SKAction sequence:@[actionScaleUp, actionScaleDownSmall, actionScaleUpSmall]];
        SKAction *actionScalingGroup = [SKAction group:@[actionFadeIn, actionScalingSequence]];
        
        SKAction *actionWrapperSequence = [SKAction sequence:@[actionWait, actionScalingGroup]];
        
        [circle runAction:actionWrapperSequence];
    }

}

- (void)runExitAnimation
{
    for (int i = 0; i < self.activeAnimationNodes.count; i++)
    {
        SKShapeNode *circle = [self.activeAnimationNodes objectAtIndex:i];
        
        SKAction *actionWait = [SKAction waitForDuration:0.5 * i];
        SKTMoveEffect *effectMoveUp = [SKTMoveEffect effectWithNode:circle
                                                           duration:3
                                                      startPosition:circle.position
                                                        endPosition:CGPointMake(circle.position.x, circle.position.y + 600)];
        
        effectMoveUp.timingFunction = SKTTimingFunctionCubicEaseIn;
        SKAction *actionMoveUp = [SKAction actionWithEffect:effectMoveUp];
        SKAction *actionFadeOut = [SKAction fadeAlphaTo:0 duration:5];
        actionFadeOut.timingMode = SKActionTimingEaseIn;
        SKAction *actionGroup = [SKAction group:@[actionMoveUp, actionFadeOut]];
        SKAction *actionSequence = [SKAction sequence:@[actionWait, actionGroup]];
        
        [circle runAction:actionSequence];
    }
}

@end
