
//
//  ShopLayer.m
//  Timber Man
//
//  Created by Jin on 7/13/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "ShopLayer.h"
#import "Global.h"

@implementation ShopLayer
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    ShopLayer *layer = [ShopLayer node];
    [scene addChild:layer];
    return scene;
}

-(id)init
{
    if(self==[super init])
    {
        
        [self createBackground];
        [self createLabels];
        [self createMenu];
    }
    return self;
}

-(void)createBackground
{
    sprShopBoard=newSpritePosA(@"bgShop", POS_SCOREBOARD, self, Z_BACK, RATIO_XY, 1.0);
    [sprShopBoard setAnchorPoint:ccp(0.5,1)];
}
-(void)createLabels
{
    if(lblBest!=nil)
    {
        [lblBest removeFromParent];
        [lblBestVal removeFromParent];
        [lblcharacterStr removeFromParent];

        [lblTotal removeFromParent];
        [lblTotalVal removeFromParent];

       [lblChop removeFromParent];
        [lblChopVal removeFromParent];
        [lblDes removeFromParent];
        [lblScore removeFromParent];
        [lblScoreVal removeFromParent];
 
        [lblLocked setVisible:FALSE];
      
       
    }
       
    lblBest=newLabel(self, @"BEST", FNT_NAME, FNT_SIZE_NORMAL, ccc3(88, 54, 31), POS_LBL_BEST_O);
    lblBestVal=newLabel(self, [NSString stringWithFormat:@"%d",getMaxScore()], FNT_NAME_BOLD, FNT_SIZE_BOLD, ccc3(255, 255, 255), POS_LBL_BEST_VAL_O);
    
    lblTotal=newLabel(self, @"TOTAL", FNT_NAME, FNT_SIZE_NORMAL, ccc3(88, 54, 31), POS_LBL_TOTAL_O);
   lblTotalVal=newLabel(self, [NSString stringWithFormat:@"%d",getTotalScore()], FNT_NAME_BOLD, FNT_SIZE_BOLD, ccc3(255, 255, 255), POS_LBL_TOTAL_VAL_O);
      lblcharacterStr=newLabel(self, gStrCharacter[currentCharacter], FNT_NAME_BOLD, FNT_SIZE_BOLD, ccc3(255, 255, 255), POS_CHARACTER_NAME);
    lblLocked=newLabel(self, @"UNLOCKED", FNT_NAME_BOLD, FNT_SIZE_BOLD, ccc3(0, 255, 0), POS_LOCK_SHOP);
    lblScoreVal=newLabel(self, [NSString stringWithFormat:@"%d",gScoreForUnlock[currentCharacter]], FNT_NAME_BOLD, FNT_SIZE_BOLD, ccc3(255, 0, 0), POS_SCORE_VAL_O);
    lblChopVal=newLabel(self, [NSString stringWithFormat:@"%d",gChopForUnlock[currentCharacter]], FNT_NAME, FNT_SIZE_BOLD, ccc3(255, 0, 0), POS_CHOP_VAL);
    
    lblScore=newLabel(self, @"SCORE", FNT_NAME, FNT_SIZE_NORMAL, ccc3(88, 54, 31), POS_SCORE_O);
    lblChop=newLabel(self, @"OR CHOP", FNT_NAME, FNT_SIZE_NORMAL, ccc3(88, 54, 31), POS_CHOP);
    lblDes=newLabel(self, @"TOTAL TO UNLOCK", FNT_NAME, FNT_SIZE_NORMAL, ccc3(88, 54, 31), POS_DESCRIPTION);
    if(isActivCharacter(currentCharacter))
    {
        [lblLocked setVisible:TRUE];
        [lblChop setVisible:FALSE];
        [lblChopVal setVisible:FALSE];
        [lblDes setVisible:FALSE];
        [lblScore setVisible:FALSE];
        [lblScoreVal setVisible:FALSE];
    }
    else
    {
        [lblLocked setVisible:FALSE];
        [lblChop setVisible:TRUE];
        [lblChopVal setVisible:TRUE];
        [lblDes setVisible:TRUE];
        [lblScore setVisible:TRUE];
        [lblScoreVal setVisible:TRUE];
    }
    
   

    

}

-(void)createMenu
{
    btnBack=newButtonPosA(@"Back",         POS_BTN_SCORE,  self, @selector(onClickBack),  false, RATIO_X, F_SCALE_BTN);
    btnSelect=newButtonPosA(@"Select", POS_BTN_PLAY, self, @selector(onClickSelect), false, RATIO_X, F_SCALE_BTN);
    btnNext=newButtonPosA(@"Next",         POS_BTN_SHOP,  self, @selector(onClickNext), false, RATIO_X, F_SCALE_BTN);
    menu=[CCMenu  menuWithItems:btnBack,btnNext,btnSelect, nil];
    [menu setPosition:ccp(0,0)];
    [self addChild:menu z:Z_BTN];
}

-(void)onClickBack
{
    if(currentCharacter>0)
    {
        currentCharacter--;
    }
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
    [gHero changeMe:currentCharacter];
    [self createLabels];
}
-(void)onClickNext
{
    if(currentCharacter<16)
    {
        currentCharacter++;
    }
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
    [gHero changeMe:currentCharacter];
    [self createLabels];
}
-(void)onClickSelect
{
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
    if(isActivCharacter(currentCharacter))
    {
        if(gIsFromMenuLayer)
        {
            [gMenuLayer hideShopAnim];
        }
        else
        {
            [gameLayer hideShopAnim];
        }
        
    }
}
@end
