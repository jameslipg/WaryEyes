//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@interface MainScene ()

@property (nonatomic, weak) CCButton *teaseButton;

@end

@implementation MainScene

- (id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)onTeaseButtonPushed {
    [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"WaryEyes"]];
}


@end
