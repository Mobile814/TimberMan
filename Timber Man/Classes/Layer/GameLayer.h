//
//  GameLayer.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer
{
    CCSprite               *sprTapLeft;
    CCSprite               *sprTapRight;
    CCProgressTimer        *mProgTimer;
    CCSprite               *sprProgBase;
    CCSprite               *sprProgBack;
    CCSprite               *sprProgBar;
    CCSprite               *sprBubble[4];
    CCLayer                *subLayer;
    CCLabelTTF             *lblScore;
    CCLabelTTF             *lblLevel;
    
    
}
+(CCScene *) scene;
-(void)gotoOverPlayer;
-(void)startBubbleAnim;
-(void)hideSubLayerAnim;
-(void)hideShopAnim;
-(void)showShopAnim;
-(void)gotoShopLayer;
-(void)showScore;
@end
