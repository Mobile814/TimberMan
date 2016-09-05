//
//  GameEndLayer.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Social/Social.h>
@interface GameEndLayer : CCLayer<MFMailComposeViewControllerDelegate>
{
    CCSprite             *sprOverBoard;
    CCMenuItemImage            *btnScore;
    CCMenuItemImage            *btnPlay;
    CCMenuItemImage            *btnShop;
    CCMenuItemImage            *btnTW;
    CCLabelTTF                 *lblScoreVal;
    CCLabelTTF                 *lblBestVal;
    CCLabelTTF                 *lblScore;
    CCLabelTTF                 *lblBest;
    CCLabelTTF                 *lblShare;
    CCMenu                     *menu;
    
}
+(CCScene *) scene;
@end
