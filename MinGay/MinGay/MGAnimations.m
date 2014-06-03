//
//  MGAnimations.m
//  MinGay
//
//  Created by Emmet William Rogan on 3/06/2014.
//  Copyright (c) 2014 MG. All rights reserved.
//

#import "MGAnimations.h"

@implementation MGAnimations

- (id)init
{
    if (self = [super init])
    {
        self.activeAnimationNodes = [[NSMutableArray alloc] init];
        
        SKLabelNode *labelListen = [[SKLabelNode alloc] initWithFontNamed:@"Lato-Light"];
        labelListen.text = @"listen";
        labelListen.fontColor = [UIColor blackColor];
        labelListen.alpha = 0.2;
        labelListen.fontSize = 25;
        labelListen.position = CGPointMake(0, 200);
        [self addChild:labelListen];
    }
    return self;
}

- (void)runCircleAnimation
{
    int numberOfCircles = 5;
    int startingDiameter = 30;
    
    for (int i = 0; i < numberOfCircles; i++) {
        SKShapeNode *circle = [[SKShapeNode alloc] init];
        
        CGMutablePathRef circlePath = CGPathCreateMutable();
        CGPathAddArc(circlePath, NULL, 0, 0, startingDiameter * (i + 1), 0, M_PI * 2, YES);
        circle.path = circlePath;
        circle.alpha = 0.04;
        circle.fillColor = [UIColor blackColor];
        
        [self addChild:circle];
        [self.activeAnimationNodes addObject:circle];
    }
}

@end
