//
//  ShopLayer.h
//  Timber Man
//
//  Created by Jin on 7/13/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ShopLayer : CCLayer
{
    CCSprite            *sprShopBoard;
    CCLabelTTF          *lblBest;
    CCLabelTTF          *lblBestVal;
    CCLabelTTF          *lblTotal;
    CCLabelTTF          *lblTotalVal;
    CCLabelTTF          *lblcharacterStr;
    CCLabelTTF          *lblScore;
    CCLabelTTF          *lblScoreVal;
    CCLabelTTF          *lblChop;
    CCLabelTTF          *lblChopVal;
    CCLabelTTF          *lblDes;
    CCLabelTTF          *lblLocked;
    CCMenuItemImage     *btnBack;
    CCMenuItemImage     *btnNext;
    CCMenuItemImage     *btnSelect;
    CCMenu              *menu;
    
}

@end
