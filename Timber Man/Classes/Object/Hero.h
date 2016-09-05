//
//  Hero.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum
{
    LEFT,
    RIGHT
}HERO_SIDE;


typedef enum

{
    HSTATE_NORMAL,
    HSTATE_CHOPPING
    
}HERO_STATE;
@interface Hero : CCSprite
{
    CCLayer       *parentLayer;
    
}
@property(nonatomic)HERO_SIDE   mSide;
@property(nonatomic)HERO_STATE  mState;
@property(nonatomic)BOOL       mIsActive;
-(id)initWithLayer:(CCLayer *)layer;
-(void)chop;
-(void)animate;
-(void)changeToRightSide;
-(void)changeToLeftSide;
-(void)changeMe:(int)idx;
@end
