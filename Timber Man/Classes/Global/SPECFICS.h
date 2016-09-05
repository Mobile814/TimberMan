//
//  SPECFICS.h
//  Run on Line
//
//  Created by Jin on 5/27/14.
//  Copyright (c) 2014 Qing Liu. All rights reserved.
//  Full rights transfered to M.K. on 7/14/14






#define REVMOB_APP_ID               @"53bb9ef766b005d106a0af4c"
#define REVMOB_BANNER_ENABLE        YES

#define CHARTBOOST_APP_ID           @"5380e42cc26ee437730f59c1"
#define CHARTBOOST_APP_SIGNATURE    @"9c5599b3bf25feba0d57626eefb83049fc1e47a0"

#define LEADERBOARD_ID             @"com.timberleaderboard"

#define ADMOB_ID                @"ca-app-pub-9919670395642849/6477643051"

#define GAME_LINK                 @"https://itunes.apple.com/us/"


typedef enum : NSUInteger
{
    Z_BG_BACK,
    Z_BIRD,
    Z_BACK,
    Z_BLOCK,
    Z_HERO,
    Z_TREE,
    Z_BUBBLE,
    Z_BTN,
    Z_SPR,
    Z_BORDER,
    Z_PROG_EMPTY,
    Z_PROG_BAR,
    Z_PROG_BASE,
    Z_SUB_LAYER
   
    
}ZORDER;


typedef enum
{
    GSTATE_READY,
    GSTATE_PLAYING,
    GSTATE_OVER,
    GSTATE_PAUSED,
    
}GAME_STATE;


