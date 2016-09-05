#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuLayer.h"
#import "GameLayer.h"
#import "GameEndLayer.h"
#import "ShopLayer.h"
#import "Hero.h"
#import "Tree.h"
#import "TreePiece.h"
#import "SPECFICS.h"
#import "Chartboost.h"
extern   int               currentLevel;
extern   int               currentScene;
extern   int               gScore;
extern   int               currentCharacter;
extern   CCAnimation       *gAnimHeroNormal[20];
extern   CCAnimation       *gAnimHeroDeactive[20];
extern   CCAnimation       *gAnimHeroChop[20];
extern   Tree              *gTree[10];
extern   Hero              *gHero;
extern   CCSprite          *sprSpace;
extern   int               currentTree;
extern   GAME_STATE        currentState;
extern   float             fProgVal;
extern   GameLayer         *gameLayer;
extern   GameEndLayer      *gameEndLayer;
extern   MenuLayer         *gMenuLayer;
extern   NSString          *gStrCharacter[20];
extern   int               gScoreForUnlock[20];
extern   int               gChopForUnlock[20];
extern   BOOL             gIsFromMenuLayer;
#define  F_SCALE_BTN    1.0
#define  INTERVAL_HERO_ANIM_NORMAL    0.3
#define  INTERVAL_HERO_ANIM_CHOP      0.1
#define  INTERVAL_TREE_DOWN           0.15
#define  INTERVAL_TREE_DOWN_FAIL      0.05
#define  INTERVAL_TREE_FLY            0.35
#define  INTERVAL_TAP                 0.4
#define  KEY_MAX_SCORE                @"MAX_SCORE"
#define  KEY_TOTAL_SCORE              @"TOTAL_SCORE"
#define  FNT_NAME                     @"Minecraftia"
#define  FNT_NAME_BOLD                @"Minecraftia"
#define FNT_SIZE_NORMAL   35
#define FNT_SIZE_BOLD     40
extern   BOOL  isActivCharacter(int idx);
extern void initAnims();
extern void initGlobalVars();
extern int   getMaxScore();
extern int   getTotalScore();
extern void addTotalScore(int currentScore);