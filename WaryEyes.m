//
//  WaryEyes.m
//  WaryEyes
//
//  Created by James Li on 8/25/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "WaryEyes.h"

@interface WaryEyes ()

@property (nonatomic, weak) CCNode *background;
@property (nonatomic, weak) CCSprite *leftEyeBall;
@property (nonatomic, weak) CCSprite *rightEyeBall;

@end


@implementation WaryEyes

- (id)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }

    return self;
}

- (BOOL)eyePoked:(CCNode *)eyeBallNode atPos:(CGPoint)pos {
    float radiusSquare = powf((eyeBallNode.contentSize.height + eyeBallNode.contentSize.width)/4, 2);
    float distanceSquare = powf(pos.x, 2) + powf(pos.y, 2);

    return distanceSquare <= radiusSquare;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint positionInLeftEyeBall = ccp([touch locationInNode:self.background].x - self.leftEyeBall.position.x,
                                        [touch locationInNode:self.background].y - self.leftEyeBall.position.y);

    CGPoint positionInRightEyeBall = ccp([touch locationInNode:self.background].x - self.rightEyeBall.position.x,
                                            [touch locationInNode:self.background].y - self.rightEyeBall.position.y);

    float radiusSquare = powf((self.leftEyeBall.contentSize.height + self.rightEyeBall.contentSize.width)/4, 2);
    float distanceSquareL = powf(positionInLeftEyeBall.x, 2) + powf(positionInLeftEyeBall.y, 2);
    float distanceSquareR = powf(positionInRightEyeBall.x, 2) + powf(positionInRightEyeBall.y, 2);

    // dont poke in the eye!
    if (distanceSquareL < radiusSquare || distanceSquareR < radiusSquare) {
        return;
    }

    NSLog(@"(%f, %f)", positionInRightEyeBall.x, positionInRightEyeBall.y);
    [self.leftEyeBall setRotation:atanf((-positionInLeftEyeBall.y)/positionInLeftEyeBall.x)*180/M_PI +
     [self angelOffset:positionInLeftEyeBall]];
    [self.rightEyeBall setRotation:atanf((-positionInRightEyeBall.y)/positionInRightEyeBall.x)*180/M_PI +
     [self angelOffset:positionInRightEyeBall]];
}

- (int)angelOffset:(CGPoint)position {
    float x = position.x;
    float y = position.y;
    if (x < 0 && y >= 0) {
        return 0;
    } else if (x >= 0 && y > 0) {
        return 180;
    } else if (x >= 0 && y <= 0) {
        return 180;
    } else {
        return 0;
    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    [self touchBegan:touch withEvent:event];
}

@end

