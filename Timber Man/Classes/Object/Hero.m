
//
//  Hero.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "Hero.h"
#import "Global.h"

@implementation Hero
@synthesize mSide;
@synthesize mState;
@synthesize mIsActive;
-(id)initWithLayer:(CCLayer *)layer
{
    if(self==[super init])
    {
        mSide=LEFT;
        parentLayer=layer;
        [self drawMe];
        mState=HSTATE_NORMAL;
    }
    return self;
}
-(void)drawMe
{

    mIsActive=isActivCharacter(currentCharacter);
    if(mIsActive)
    {
         self=[super initWithFile:[NSString stringWithFormat:@"man%d0.png",currentCharacter]];
          [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:gAnimHeroNormal[currentCharacter]]]];
    }
    else
    {
         self=[super initWithFile:[NSString stringWithFormat:@"mand%d0.png",currentCharacter]];
          [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:gAnimHeroDeactive[currentCharacter]]]];
    }
   
  
    [self setPosition:getScaledPos(POS_HERO_LEFT)];
    [self setAnchorPoint:ccp(0.5,0)];
    [self setScaleX:G_SCALEY];
    [self setScaleY:G_SCALEY];
    [self setOpacity:255];
    [parentLayer addChild:self z:Z_HERO];
    self.mState=HSTATE_NORMAL;


}
-(void)changeMe:(int)idx
{
    CCTexture2D *tex1;
    if(isActivCharacter(idx))
    {
        tex1= [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"man%d0.png",idx]];

    }
    else
    {
         tex1= [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"mand%d0.png",idx]];
    }

    [self setTexture:tex1];
    [self animate];
}
-(void)changeToRightSide
{
    if(self.mSide==LEFT)
    {
        self.mSide=RIGHT;
         [self  setPosition:getScaledPos(POS_HERO_RIGHT)];
        [self setFlipX:true];
    }

    
}
-(void)changeToLeftSide
{
    if(self.mSide==RIGHT)
    {
        self.mSide=LEFT;
        [self  setPosition:getScaledPos(POS_HERO_LEFT)];
        [self setFlipX:false];
    }

}
-(void)animate
{
      [self stopAllActions];
    if(isActivCharacter(currentCharacter))
    {
         [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:gAnimHeroNormal[currentCharacter]]]];
    }
    else
    {
         [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:gAnimHeroDeactive[currentCharacter]]]];
    }
  
   
}
-(void)chop
{
    if(self.mState==HSTATE_NORMAL && currentState==GSTATE_PLAYING)
    {
        [gTree[currentTree] setVisible:false];
        int idx=(currentTree==0)?9:currentTree-1;
        int idxFail=(currentTree==9)?0:currentTree+1;
        if(gTree[idxFail].mSide==self.mSide  && gTree[idxFail].mKind==TREE_BRANCH)
        {
            for(int i=0;i<10;i++)
            {
                [gTree[i] moveFail];
                [[SimpleAudioEngine sharedEngine]playEffect:@"fail.mp3"];
            }
        }
        else if(gTree[currentTree].mSide==self.mSide  && gTree[currentTree].mKind==TREE_BRANCH)
        {
            for(int i=0;i<10;i++)
            {
                [gTree[i] moveFail];
                [[SimpleAudioEngine sharedEngine]playEffect:@"fail.mp3"];
            }
        }
        else
        {
          
            gScore++;
             [[SimpleAudioEngine sharedEngine]playEffect:@"chop.mp3"];
            [gameLayer showScore];
            self.mState=HSTATE_CHOPPING;
            [self stopAllActions];
            fProgVal+=2.0;
            [[TreePiece alloc]initWithLayer:parentLayer withSide:!mSide withType:gTree[currentTree].mKind];
              [ gTree[currentTree] changeMe:gTree[idx].position.y+Y_INTERVAL/2*G_SCALEY/g_fScaleR ];
            [sprSpace setOpacity:255];
            [sprSpace runAction:[CCFadeTo actionWithDuration:0.2 opacity:0]];
            currentTree=(currentTree+1)%10;
            [self runAction:[CCSequence actions:[CCAnimate actionWithAnimation:gAnimHeroChop[currentCharacter]] ,[CCCallFuncN actionWithTarget:self selector:@selector(checkChopState)], nil]];
        }
 
    }

}
-(void)checkChopState
{
    for(int i=0;i<10;i++)
    {
        [gTree[i] moveDown];
    }
   
    [self animate];
    self.mState=HSTATE_NORMAL;

}
@end
