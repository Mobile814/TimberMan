//
//  AppDelegate.h
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright Jin 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "Chartboost.h"
#import "GameCenterManager.h"
#import <GameKit/GameKit.h>
#import "GADInterstitial.h"
// Added only for iOS 6 support
@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate,GKAchievementViewControllerDelegate, GameCenterManagerDelegate, GKLeaderboardViewControllerDelegate,ChartboostDelegate,GADInterstitialDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;
    GameCenterManager* gameCenterManager_;
     NSString* currentLeaderBoard_;//
	CCDirectorIOS	*director_;
    GADInterstitial  *interstitial_;// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) MyNavigationController *navController;
@property (readonly) CCDirectorIOS *director;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
@property (nonatomic, retain) NSString* currentLeaderBoard;

+(AppController*) get;
-(void)submitScore:(int)score;
-(void) dispRevmobInterstitial;
-(void)showLeaderboard;
-(void)showRate;
-(void)showAdmobInterstitial;

@end
