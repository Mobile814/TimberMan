//
//  Global.m
//  WavyLine
//
//  Created by Qing Liu on 5/22/14.
//  Copyright (c) 2014 Qing Liu. All rights reserved.
//

#import "Global.h"

float          g_fScaleR;
CCParticleExplosion   *m_pStarsExplosion;
CGPoint        getScaledPos(CGPoint  originPos)
{
    return ccp(getX(originPos.x),getY(originPos.y));
}
CCMenuItemLabel *newLabelButtonPos(NSString* btnTxt,NSString *txtFnt ,int fntSize,CGPoint pt, id target, SEL selector, int nRatio)
{
    
    
    CCLabelTTF *lbl = [CCLabelTTF labelWithString:btnTxt fontName:txtFnt fontSize:fntSize];
    
    CCMenuItemLabel *item1 = [CCMenuItemLabel itemWithLabel:lbl target:target selector:selector];
    setScale(item1, nRatio);
    [item1 setPosition:ccp(getX(pt.x),getY(pt.y))];
    return item1;
}

float getX(int x)
{
    float fx;
    
    fx = G_SWIDTH * x / G_ORG_WIDTH;
    return fx;
}

float getY(int y)
{
    float fy;
    fy = G_SHEIGHT - G_SHEIGHT * y / G_ORG_HEIGHT;
    return fy;
}

CGPoint MP()
{
    return ccp(384,512);
}

float MX()
{
    return getX(384);
}

float MY()
{
    return getY(512);
}


void startParticle ( CCLayer *parentLayer,NSString *plistPath,CGPoint point,float durationTime,float ratio)
{
    m_pStarsExplosion = [CCParticleExplosion particleWithFile:plistPath];
    
    m_pStarsExplosion.scaleX = ratio;
    m_pStarsExplosion.scaleY = ratio;
    m_pStarsExplosion.position = point;
    [m_pStarsExplosion setDuration:durationTime];
    [m_pStarsExplosion resetSystem];
    [parentLayer addChild: m_pStarsExplosion z: 20];
    

}

CCLabelTTF* newLabel( CCLayer *layer,NSString * str,NSString *fontName ,int size ,ccColor3B color,CGPoint pos)
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:fontName fontSize:size];
    label.scale = G_SCALEY / g_fScaleR;
    [layer addChild: label z:99];
    [label setColor:color];
    label.anchorPoint = ccp(0.5, 0.5);
    label.position = ccp(getX(pos.x),getY(pos.y));
    return label;
}

CCSprite *newSpriteA(NSString *sName, float x, float y, id target, int zOrder, int nRatio,float ratio)
{
    CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",sName]];
    setScaleArbitrary(sprite, nRatio,ratio);
    
    sprite.position = ccp(x, y);
    [target addChild:sprite z:zOrder];
    return sprite;
}

CCSprite *newSprite(NSString *sName, float x, float y, id target, int zOrder, int nRatio)
{
    CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",sName]];
    setScale(sprite, nRatio);
    
    sprite.position = ccp(x, y);
    [target addChild:sprite z:zOrder];
    return sprite;
}

CCSprite *newSpritePosA(NSString *sName, CGPoint pt, id target, int zOrder, int nRatio,float ratio)
{
    CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png",sName]];
    setScaleArbitrary(sprite, nRatio,ratio);
    
    sprite.position =ccp(getX(pt.x),getY(pt.y));
    [target addChild:sprite z:zOrder];
    return sprite;
}
CCMenuItemImage *newButtonPos(NSString* btnName, CGPoint pt, id target, SEL selector, BOOL isOneImage, int nRatio)
{
    CCMenuItemImage *item;
    
    if(isOneImage)
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn-%@.png", btnName] selectedImage:[NSString stringWithFormat:@"btn-%@.png", btnName] target:target selector:selector];
    else
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@N.png", btnName] selectedImage:[NSString stringWithFormat:@"%@P.png", btnName] target:target selector:selector];
    setScale(item, nRatio);
    item.position =ccp(getX(pt.x),getY(pt.y));
    return item;
}
CCMenuItemImage *newButtonPosA(NSString* btnName, CGPoint pt, id target, SEL selector, BOOL isOneImage, int nRatio,float ratio)
{
    CCMenuItemImage *item;
    
    if(isOneImage)
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn-%@.png", btnName] selectedImage:[NSString stringWithFormat:@"btn-%@.png", btnName] target:target selector:selector];
    else
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn%@Normal.png", btnName] selectedImage:[NSString stringWithFormat:@"btn%@Pressed.png", btnName] target:target selector:selector];
    setScaleArbitrary(item, nRatio,ratio);
    item.position =ccp(getX(pt.x),getY(pt.y));
    return item;
}



CCMenuItemImage *newButtonArbitrary(NSString* btnName, float x, float y, id target, SEL selector, BOOL isOneImage, int nRatio,float ratio)
{
    CCMenuItemImage *item;
    
    if(isOneImage)
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn-%@.png", btnName] selectedImage:[NSString stringWithFormat:@"btn-%@.png", btnName] target:target selector:selector];
    else
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"btn_%@_normal.png", btnName] selectedImage:[NSString stringWithFormat:@"btn_%@_pressed.png", btnName] target:target selector:selector];
    setScaleArbitrary(item, nRatio,ratio);
    item.position = ccp(x, y);
    return item;
}

void setScale(CCNode *node, int nRatio)
{
    if(nRatio == RATIO_XY)
    {
        node.scaleX = G_SCALEX;
        node.scaleY = G_SCALEY;
    }
    else if(nRatio == RATIO_X)
        node.scale = G_SCALEX;
    else if(nRatio == RATIO_Y)
        node.scale = G_SCALEY;
}


void setScaleArbitrary(CCNode *node, int nRatio,float ratio)
{
    if(nRatio == RATIO_XY)
    {
        node.scaleX = G_SCALEX*ratio;
        node.scaleY = G_SCALEY*ratio;
    }
    else if(nRatio == RATIO_X)
        node.scale = G_SCALEX*ratio;
    else if(nRatio == RATIO_Y)
        node.scale = G_SCALEY*ratio;
}




CGFloat g_fx = 1.0f;
CGFloat g_fy = 1.0f;

CGFloat g_fs = 1.0f;
CGFloat g_fh = 1.0f;
CGFloat g_fsh = 1.0f;

CGFloat g_fMaginIphone5 = 0;
CGSize  g_mySize;

int     g_nScore = 0;
bool    g_bIsGameOver = false;




CCSprite *addBackground(NSString *sName, CGPoint pos, id target, int zOrder)
{
    CCSprite *sprite;
    
    sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", sName]];
    sprite.scaleX = g_fs;
    sprite.scaleY = g_fsh;
    
    sprite.position = pos;
    [target addChild:sprite z:zOrder];
    
    return sprite;
}

CCSprite *addSprite(NSString *sName, CGPoint pos, id target, int zOrder)
{
    CCSprite *sprite = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%@.png", sName]];
    sprite.scale = g_fs;
    
    sprite.position = pos;
    [target addChild:sprite z:zOrder];
    
    return sprite;
}

CCMenuItemImage *addButton(NSString* btnName, CGPoint pos, id target, SEL selector)
{
    CCMenuItemImage *item;
    
    item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"bt_%@.png", btnName] selectedImage:[NSString stringWithFormat:@"bt_%@_d.png", btnName] target:target selector:selector];
    item.scale = g_fs;
    item.position = pos;
    
    return item;
}

CCMenuItemImage *addSingleButton(NSString* btnName, CGPoint pos, id target, SEL selector)
{
    CCMenuItemImage *item;
    
    item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"bt_%@.png", btnName] selectedImage:[NSString stringWithFormat:@"bt_%@.png", btnName] target:target selector:selector];
    item.scale = g_fs;
    item.position = pos;
    
    return item;
}

CCMenuItemImage *addFullButton(NSString* btnName, CGPoint pos, id target, SEL selector, BOOL isSingle)
{
    CCMenuItemImage *item;
    
    if (isSingle) {
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"bt_%@.png", btnName] selectedImage:[NSString stringWithFormat:@"bt_%@.png", btnName] disabledImage:[NSString stringWithFormat:@"bt_%@_no.png", btnName] target:target selector:selector];
    } else {
        item = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"bt_%@.png", btnName] selectedImage:[NSString stringWithFormat:@"bt_%@_d.png", btnName] disabledImage:[NSString stringWithFormat:@"bt_%@_no.png", btnName] target:target selector:selector];
    }
    item.scale = g_fs;
    item.position = pos;
    
    return item;
}

CCMenuItem *addTextButton(NSString* strLabel, CGPoint pos, CGFloat fontSize, ccColor3B color, id target, SEL selector)
{
    CCMenuItem *item;
    
    item = [CCMenuItemFont itemWithString:strLabel target:target selector:selector];
    [(CCMenuItemFont*)item setFontSize:fontSize];
    [(CCMenuItemFont*)item setColor:color];
    item.position = pos;
    
    return item;
}

CCMenuItemToggle *addToggleButton(NSString *btnName, CGPoint pos, id target, SEL selector)
{
    CCMenuItemToggle *item;
    CCMenuItemImage *itemOn, *itemOff;
    
    itemOn = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@ on.png", btnName] selectedImage:[NSString stringWithFormat:@"%@ on.png", btnName]];
    
    itemOff = [CCMenuItemImage itemWithNormalImage:[NSString stringWithFormat:@"%@ off.png", btnName] selectedImage:[NSString stringWithFormat:@"%@ off.png", btnName]];
    
    item = [CCMenuItemToggle itemWithTarget:target selector:selector items:itemOn, itemOff, nil];
    item.scale = g_fs;
    item.position = pos;
    
    return item;
}


