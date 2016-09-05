//
//  GameLayer.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "GameLayer.h"
#import "Global.h"

@implementation GameLayer
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    GameLayer *layer = [GameLayer node];
    [scene addChild:layer];
    return scene;
}
-(id)init{
    if (self =[super init]) {
        gameLayer=self;
        currentTree=0;
        initGlobalVars();
        [self createBackground];
        [self initLabel];
        [self initObjects];
        [self setTouchEnabled:true];
        [self initProgressTimer];
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"bg.mp3"];

        
        
    }
    return  self;
}

-(void)initProgressTimer
{
   sprProgBase=newSpritePosA(@"progressBase", POS_PROG_BASE, self, Z_PROG_BASE, RATIO_X, 1.0);
   sprProgBack=newSpritePosA(@"progressEmpty", POS_PROG_BASE, self, Z_PROG_EMPTY, RATIO_X, 1.0);
    CCSprite *sprBar = [CCSprite spriteWithFile:@"progressBar.png"];
    mProgTimer = [CCProgressTimer progressWithSprite:sprBar];
    mProgTimer.position =getScaledPos(POS_PROG_BASE);
    mProgTimer.scale = G_SCALEX;
    mProgTimer.barChangeRate = ccp(1,0);
    mProgTimer.midpoint = ccp(0, 0);
    mProgTimer.type = kCCProgressTimerTypeBar;
    
    mProgTimer.percentage =60;
    fProgVal=60;// for bullet which should be changed
    [self addChild:mProgTimer z:Z_PROG_BAR];
}
-(void)watchTimer:(float)dt
{
    fProgVal-=0.15;
    mProgTimer.percentage=fProgVal;
    if(fProgVal<0.2)
    {

        [self startBubbleAnim];
        [[SimpleAudioEngine sharedEngine]playEffect:@"fail.mp3"];
        [self unschedule:@selector(watchTimer:)];
    }
}
-(void)initLabel
{
    lblScore=newLabel(self, @"0", FNT_NAME_BOLD, FNT_SIZE_BOLD, ccWHITE, POS_LBL_SCORE);
    lblLevel=newLabel(self, @"Level 2", FNT_NAME_BOLD, FNT_SIZE_BOLD, ccYELLOW, POS_LBL_LEVEL);
    [lblLevel setVisible:false];
}

-(void)showScore
{
    [lblScore setString:[NSString stringWithFormat:@"%d",gScore]];
    if(gScore>0 && gScore%20==0)
    {
        currentLevel++;
        [[SimpleAudioEngine sharedEngine]playEffect:@"level.mp3"];
        [lblLevel setString:[NSString stringWithFormat:@"Level %d",currentLevel]];
        [lblLevel setPosition:getScaledPos(POS_LBL_LEVEL)];
        [lblLevel setVisible:true];
        [lblLevel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0],[CCMoveTo actionWithDuration:0.5 position:getScaledPos(POS_LBL_LEVEL_END)],[CCCallFuncN actionWithTarget:self selector:@selector(hideLevelLabel)], nil]];
    }
}
-(void)hideLevelLabel
{
    [lblLevel setVisible:false];
}
-(void)createBackground
{
      newSpritePosA([NSString stringWithFormat:@"bgPlayBack%d",currentScene],     MP(), self,Z_BG_BACK, RATIO_XY,1.0);
       newSpritePosA([NSString stringWithFormat:@"bgPlay%d",currentScene],     MP(), self,Z_BACK, RATIO_XY,1.0);       sprSpace=newSpritePosA(@"sprSpace", POS_SPR_SPACE, self, Z_BTN, RATIO_XY, 1.0);
        [sprSpace setOpacity:0];
       sprTapLeft=newSpritePosA(@"sprTapLeft",   POS_SPR_TAP_LEFT_START, self, Z_BTN, RATIO_X, 1.0);
       sprTapRight=newSpritePosA(@"sprTapRight", POS_SPR_TAP_RIGHT_START, self, Z_BTN, RATIO_X, 1.0);
    
    [sprTapLeft runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveTo actionWithDuration:INTERVAL_TAP position:getScaledPos(POS_SPR_TAP_LEFT_END)],[CCMoveTo actionWithDuration:INTERVAL_TAP position:getScaledPos(POS_SPR_TAP_LEFT_START)], nil]]];
    
     [sprTapRight runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCMoveTo actionWithDuration:INTERVAL_TAP position:getScaledPos(POS_SPR_TAP_RIGHT_END)],[CCMoveTo actionWithDuration:INTERVAL_TAP position:getScaledPos(POS_SPR_TAP_RIGHT_START)], nil]]];
    
    
}

-(void)initObjects
{
    gHero=[[Hero alloc]initWithLayer:self];
    
    for(int i=0;i<10;i++)
    {
        gTree[i]=[[Tree alloc]initWithLayer:self withIdx:i];
    }
}


-(void)startBubbleAnim
{
    [self unschedule:@selector(watchTimer:)];
    currentState=GSTATE_OVER;
   
    CGPoint    ptDest[4];
    [gHero stopAllActions];
    for(int i=0;i<4;i++)
    {
        sprBubble[i]=newSpriteA(@"sprBubble", [gHero boundingBox].origin.x+[gHero boundingBox].size.width/2,[gHero boundingBox].origin.y+[gHero boundingBox].size.height/2, self, Z_BUBBLE, RATIO_X, 0.01);
        [sprBubble[i] setOpacity:80];
        float mAngle=45+90*i;
        ptDest[i]=ccp(sprBubble[i].position.x+35*sinf(mAngle/180*M_PI)*G_SCALEX,sprBubble[i].position.y+35*cosf(mAngle/180*M_PI)*G_SCALEX);
        
        
    }
    
    
    
    for(int i=0;i<4;i++)
    {
        if(i<3)
        {
            [sprBubble[i] runAction:[CCMoveTo actionWithDuration:0.2 position:ptDest[i]]];
            [sprBubble[i] runAction:[CCScaleBy actionWithDuration:0.3 scale:80]];
        }
        else
        {
            [sprBubble[i] runAction:[CCMoveTo actionWithDuration:0.2 position:ptDest[i]]];
            [sprBubble[i] runAction:[CCSequence actions:[CCScaleBy actionWithDuration:0.3 scale:80],[CCCallFuncN actionWithTarget:self selector:@selector(gotoOverPlayer)] ,nil]];
        }
    }
    
    
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray* touchArray = [touches allObjects];
    
    for(int i = 0 ; i < [touchArray count]; i++)
    {
        UITouch *touch = [touchArray objectAtIndex:i];
        CGPoint touchLocation = [touch locationInView: [touch view]];
        touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
        if(currentState==GSTATE_READY)
        {
            currentState=GSTATE_PLAYING;
            [sprTapLeft removeFromParent];
            [sprTapRight removeFromParent];
            [self schedule:@selector(watchTimer:) interval:0.01];
        }
        if(currentState==GSTATE_PLAYING)
        {
            if(touchLocation.x<getX(384))
            {
                [gHero changeToLeftSide];
            }
            else
            {
                [gHero changeToRightSide];
            }
            [gHero chop];
        }

    }
}


-(void)hideSubLayerAnim
{
    [subLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.25 position:ccp(0,getY(-512)) ],[CCCallFuncN actionWithTarget:self selector:@selector(startNewGame)], nil]];
}

-(void)startNewGame
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[GameLayer scene]]];
}
-(void)gotoOverPlayer
{
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    [sprProgBack setVisible:false];
    [mProgTimer setVisible:false];
    [sprProgBase setVisible:false];
    [gHero setVisible:false];
    [lblScore setVisible:FALSE];
    [lblLevel setVisible:FALSE];
    for(int i=0;i<4;i++)
    {
        [sprBubble[i] setVisible:false];
    }
    subLayer=[[CCLayer alloc]init];
    [self addChild:subLayer z:Z_SUB_LAYER];
    [subLayer setPosition:ccp(0,getY(-512)) ];
    [subLayer addChild:[GameEndLayer node] z:Z_HERO];
    [subLayer runAction:[CCMoveTo actionWithDuration:0.25 position:ccp(0,0)]];
}

-(void)gotoShopLayer

{    [gHero removeFromParent];
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
     gHero=[[Hero alloc]initWithLayer:self];
     [subLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.25 position:ccp(0,getY(-512)) ],[CCCallFuncN actionWithTarget:self selector:@selector(showShopAnim)], nil]];
}
-(void)showShopAnim
{
    subLayer=[[CCLayer alloc]init];
    [self addChild:subLayer z:Z_SUB_LAYER];
    [subLayer setPosition:ccp(0,getY(-512)) ];
    [subLayer addChild:[ShopLayer node] z:Z_HERO];
    [subLayer runAction:[CCMoveTo actionWithDuration:0.25 position:ccp(0,0)]];
 
}
-(void)hideShopAnim
{
        [subLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.25 position:ccp(0,getY(-512)) ],[CCCallFuncN actionWithTarget:self selector:@selector(gotoMenuLayer)], nil]];
}
-(void)gotoMenuLayer
{
    [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[MenuLayer scene]]];
}
@end

