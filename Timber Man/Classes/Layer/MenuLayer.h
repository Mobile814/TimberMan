//
//  MenyLayer.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MenuLayer: CCLayer
{
    CCSprite                    *sprLogo;
    CCMenuItemImage             *btnScore;
    CCMenuItemImage             *btnPlay;
    CCMenuItemImage             *btnShop;
    CCMenu                      *menu;
    CCLayer                     *subLayer;
}
+(CCScene *) scene;
-(void)hideShopAnim;
@end
