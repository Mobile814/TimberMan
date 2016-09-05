//
//  Global.h
//  WavyLine
//
//  Created by Qing Liu on 5/22/14.
//  Copyright (c) 2014 Qing Liu. All rights reserved.
//


#ifndef _GLOBAL_H_
#define _GLOBAL_H_

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "SimpleAudioEngine.h"
#import "AppDelegate.h"
#import "SPECFICS.h"
#import "CustomVar.h"
#import "POSITION.h"

#define G_ORG_WIDTH  768
#define G_ORG_HEIGHT 1024
#ifdef UI_USER_INTERFACE_IDIOM//()
#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (NO)
#endif

#define G_SWIDTH    (IS_IPAD() ? 768: [[CCDirector sharedDirector] winSize].width)  //Screen width
#define G_SHEIGHT   (IS_IPAD() ? 1024: [[CCDirector sharedDirector] winSize].height)   //Screen height

#define G_SCALEX    (G_SWIDTH * g_fScaleR / G_ORG_WIDTH)
#define G_SCALEY    (G_SHEIGHT * g_fScaleR / G_ORG_HEIGHT)
struct GAME_INFO {
    int bestScore;
};
typedef enum
{
    RATIO_XY = 0,
    RATIO_X,
    RATIO_Y,
}Ratio;


float getX(int x);
float getY(int y);
extern CGPoint        getScaledPos(CGPoint  originPos);
extern float g_fScaleR;
extern CCParticleExplosion   *m_pStarsExplosion;
void startParticle ( CCLayer *parentLayer,NSString *plistPath,CGPoint point,float durationTime,float ratio);
CGPoint MP();
float MX();
float MY();
int getBestScore();
CCLabelTTF* newLabel( CCLayer *layer,NSString * str,NSString *fontName ,int size ,ccColor3B color,CGPoint pos);
CCMenuItemLabel *newLabelButtonPos(NSString* btnTxt,NSString *txtFnt ,int fntSize,CGPoint pt, id target, SEL selector, int nRatio);

CCSprite *newSpriteA(NSString *sName, float x, float y, id target, int zOrder, int nRatio,float ratio);
CCSprite *newSprite(NSString *sName, float x, float y, id target, int zOrder, int nRatio);
CCSprite *addBackground(NSString *sName, CGPoint pos, id target, int zOrder);
CCSprite *addSprite(NSString *sName, CGPoint pos, id target, int zOrder);
CCMenuItemImage *addButton(NSString* btnName, CGPoint pos, id target, SEL selector);
CCMenuItemImage *addSingleButton(NSString* btnName, CGPoint pos, id target, SEL selector);
CCMenuItemImage *addFullButton(NSString* btnName, CGPoint pos, id target, SEL selector, BOOL isSingle);
CCMenuItem *addTextButton(NSString* strLabel, CGPoint pos, CGFloat fontSize, ccColor3B color, id target, SEL selector);
CCMenuItemToggle *addToggleButton(NSString *btnName, CGPoint pos, id target, SEL selector);
CCLabelTTF *addLabel(CGPoint pos, CCNode *scene, NSString *str, ccColor3B color, CGFloat fontSize, int zOrder);
CCSprite *newSpritePosA(NSString *sName, CGPoint pt, id target, int zOrder, int nRatio,float ratio);
CCSprite *newSpritePos(NSString *sName, CGPoint pt, id target, int zOrder, int nRatio);
CCMenuItemImage *newButtonPos(NSString* btnName, CGPoint pt, id target, SEL selector, BOOL isOneImage, int nRatio);
CCMenuItemImage *newButtonPosA(NSString* btnName, CGPoint pt, id target, SEL selector, BOOL isOneImage, int nRatio,float ratio);
void setScale(CCNode *node, int nRatio);
void setScaleArbitrary(CCNode *node, int nRatio,float ratio);
#endif