//
//  MenyLayer.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "MenuLayer.h"
#import "Global.h"

@implementation MenuLayer
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    MenuLayer *layer = [MenuLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init{
    if (self =[super init]) {
        gMenuLayer=self;
        initGlobalVars();
        [self initSubLayer];
        [self createBackground];
        [self createMenu];
        [self drawHero];
        
        
    }
    return  self;
}
-(void)initSubLayer
{
    subLayer=[[CCLayer alloc]init];
    [self addChild:subLayer z:Z_SUB_LAYER];
}
-(void)createBackground
{
    currentScene=arc4random()%3;
     newSpritePosA([NSString stringWithFormat:@"bgPlayBack%d",currentScene],     MP(), self,Z_BG_BACK, RATIO_XY,1.0);
    newSpritePosA([NSString stringWithFormat:@"bgPlay%d",currentScene],     MP(), self,Z_BACK, RATIO_XY,1.0);
    sprLogo=newSpritePosA(@"sprTitle",POS_SPR_LOGO, subLayer,Z_SPR, RATIO_X,1.0);

}
-(void)drawHero
{
   gHero= [[Hero alloc]initWithLayer:self];
}
-(void)createMenu
{
    btnPlay=newButtonPosA(@"Play",         POS_BTN_PLAY,  self, @selector(onClickPlay),  false, RATIO_X, F_SCALE_BTN);
    btnScore=newButtonPosA(@"Leaderboard", POS_BTN_SCORE, self, @selector(onClickScore), false, RATIO_X, F_SCALE_BTN);
    btnShop=newButtonPosA(@"Shop",         POS_BTN_SHOP,  self, @selector(onClickShop), false, RATIO_X, F_SCALE_BTN);
    menu=[CCMenu  menuWithItems:btnPlay,btnScore,btnShop, nil];
    [menu setPosition:ccp(0,0)];
    [subLayer addChild:menu z:Z_BTN];

}
-(void)hideMenu
{
     [subLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.25 position:ccp(0,getY(-512)) ],[CCCallFuncN actionWithTarget:self selector:@selector(gotoShopLayer)], nil]];
}
-(void)showMenu
{
    [subLayer setPosition:ccp(0,getY(-512)) ];
    [subLayer addChild:[ShopLayer node] z:Z_HERO];
    [subLayer runAction:[CCMoveTo actionWithDuration:0.25 position:ccp(0,0)]];

}
-(void)onClickPlay
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[GameLayer scene]]];
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
}
-(void)onClickScore
{
    [[AppController get]showLeaderboard];
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
}
-(void)onClickShop
{
    [self hideMenu];
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
}
-(void)gotoShopLayer
{
    [gHero removeFromParent];
  [gHero stopAllActions];
   gHero=[[Hero alloc]initWithLayer:self];
    [subLayer runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.25 position:ccp(0,getY(-512)) ],[CCCallFuncN actionWithTarget:self selector:@selector(showShopAnim)], nil]];
}
-(void)showShopAnim
{
    gIsFromMenuLayer=true;
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
    gIsFromMenuLayer=false;
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[MenuLayer scene]]];
}
@end
