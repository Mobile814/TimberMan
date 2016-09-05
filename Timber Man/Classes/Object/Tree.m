  
//
//  Tree.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "Tree.h"
#import "Global.h"

@implementation Tree
@synthesize mIdx;
@synthesize mKind;
@synthesize mSide;


-(id)initWithLayer:(CCLayer *)layer withIdx:(int)idx
{
    if(self==[super init])
    {
        mSide=LEFT;
        mIdx=idx;
        parentLayer=layer;
        [self drawMe];
       
    }
    return self;
}
-(void)drawMe
{
    mSide=arc4random()%2;
    mKind=TREE_PURE;
    if(mIdx%2==0 && mIdx>0)

    {
         if(arc4random()%8!=0)
             mKind=TREE_BRANCH;
    }
   
    
    int xPos=(mSide==LEFT)?X_TREE_LEFT:X_TREE_RIGHT;
    self=[super initWithFile:[NSString stringWithFormat:@"tree%d.png",currentScene]];
    if(mKind==TREE_PURE)
    {
        [self setVisible:false];
    }
  
    [self setPosition:getScaledPos(ccp(xPos, Y_TREE_INITIAL-mIdx*Y_INTERVAL/2))];
    [self setAnchorPoint:(mSide==LEFT)?ccp(1,0.5):ccp(0,0.5)];
      [self setFlipX:(mSide==LEFT)?TRUE:FALSE];
    [self setScaleX:G_SCALEX];
    [self setScaleY:G_SCALEX];
    [self setOpacity:255];
    [parentLayer addChild:self z:Z_TREE];
   
}

-(void)moveDown
{
    [self runAction:[CCMoveTo  actionWithDuration:INTERVAL_TREE_DOWN position:ccp(self.position.x,self.position.y-Y_INTERVAL/2*G_SCALEY/g_fScaleR)]];
}

-(void)moveFail
{
   if(mIdx==9)
   {
        [self runAction:[CCSequence actions:[CCMoveTo  actionWithDuration:INTERVAL_TREE_DOWN position:ccp(self.position.x,self.position.y-Y_INTERVAL/2*G_SCALEY/g_fScaleR)],[CCCallFuncN actionWithTarget:self selector:@selector(startBubbleAnim)] ,nil]];
   }
    else
    {
            [self runAction:[CCMoveTo  actionWithDuration:INTERVAL_TREE_DOWN position:ccp(self.position.x,self.position.y-Y_INTERVAL/2*G_SCALEY/g_fScaleR)]];
    }

}

-(void)startBubbleAnim
{
    [gameLayer startBubbleAnim];
}


-(void)changeMe:(float)yPos
{
    mSide=arc4random()%2;
    mKind=TREE_PURE;
    if(mIdx%2==0 )
    {
        if(arc4random()%8!=0)
            mKind=TREE_BRANCH;
    }
    [self setVisible:true];
    
    int xPos=(mSide==LEFT)?X_TREE_LEFT:X_TREE_RIGHT;
   
    CCTexture2D *tex1= [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"tree%d.png",currentScene]];
    [self setTexture:tex1];
    if(mKind==TREE_PURE)
    {
        [self setVisible:false];
    }
    [self setFlipX:(mSide==LEFT)?TRUE:FALSE];
    [self setPosition:ccp(getX(xPos),yPos)];
      [self setAnchorPoint:(mSide==LEFT)?ccp(1,0.5):ccp(0,0.5)];
}
@end
