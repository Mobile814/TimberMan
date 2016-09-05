//
//  TreePiece.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "TreePiece.h"
#import "Global.h"

@implementation TreePiece
@synthesize mSide;
@synthesize mKind;
-(id)initWithLayer:(CCLayer *)layer withSide:(int)side  withType:(int)treeWithBranch
{
    if(self==[super init])
    {
        mSide=side;
        mKind=treeWithBranch;

        parentLayer=layer;
        [self drawMe];
        [self flyOver];
        
    }
    return self;
}

-(void)drawMe
{
    self=[super initWithFile:[NSString stringWithFormat:@"tree%d%d.png",currentScene,mKind]];

    [self setFlipX:(mSide==LEFT)?TRUE:FALSE];
    [self setPosition:getScaledPos(ccp(384,Y_TREE_INITIAL))];
    [self setAnchorPoint:ccp(0.5,0.5)];
    [self setScaleX:G_SCALEY];
    [self setScaleY:G_SCALEY];
    [self setOpacity:255];
    [parentLayer addChild:self z:Z_TREE];
 
}

-(void)flyOver
{
    float  xTargetPos=(mSide==LEFT)?-70:830;
    float  angle=(mSide==LEFT)?-180:180;
    [self runAction:[CCMoveTo actionWithDuration:INTERVAL_TREE_FLY position:getScaledPos(ccp(xTargetPos,Y_TREE_INITIAL))]];
    [self runAction:[CCSequence actions:[CCRotateBy actionWithDuration:INTERVAL_TREE_FLY angle:angle],[CCCallFuncN actionWithTarget:self selector:@selector(removeMe)] ,nil]];
    
}
-(void)removeMe
{
    [self removeFromParent];
   
}
@end
