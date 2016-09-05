#import "CustomVar.h"
#import "Global.h"

int               currentLevel=1;;
int               currentScene;
int               gScore;
Tree              *gTree[10];
float             fProgVal;
CCAnimation       *gAnimHeroNormal[20];
CCAnimation       *gAnimHeroDeactive[20];
CCAnimation       *gAnimHeroChop[20];
Hero              *gHero;
CCSprite          *sprSpace;
int               currentTree;
GAME_STATE        currentState=GSTATE_READY;
 GameLayer         *gameLayer;
GameEndLayer       *gameEndLayer;
NSString          *gStrCharacter[20];
int               gScoreForUnlock[20];
int               gChopForUnlock[20];
int               currentCharacter;
BOOL             gIsFromMenuLayer;
MenuLayer         *gMenuLayer;
void initAnims()
{
    for(int i=0;i<17;i++)
    {
        gAnimHeroNormal[i]=[[CCAnimation alloc]init];
        gAnimHeroDeactive[i]=[[CCAnimation alloc]init];
        gAnimHeroChop[i]=[[CCAnimation alloc]init];
        gAnimHeroNormal[i].delayPerUnit =INTERVAL_HERO_ANIM_NORMAL;
        gAnimHeroDeactive[i].delayPerUnit =INTERVAL_HERO_ANIM_NORMAL;
        gAnimHeroChop[i].delayPerUnit =INTERVAL_HERO_ANIM_CHOP;
        
        [gAnimHeroNormal[i] addSpriteFrameWithFilename:[NSString stringWithFormat:@"man%d1.png",i]];
        [gAnimHeroNormal[i] addSpriteFrameWithFilename:[NSString stringWithFormat:@"man%d0.png",i]];
        [gAnimHeroChop[i] addSpriteFrameWithFilename:[NSString stringWithFormat:@"man%d2.png",i]];
        [gAnimHeroChop[i] addSpriteFrameWithFilename:[NSString stringWithFormat:@"man%d1.png",i]];
        
        [gAnimHeroDeactive[i] addSpriteFrameWithFilename:[NSString stringWithFormat:@"mand%d1.png",i]];
        [gAnimHeroDeactive[i] addSpriteFrameWithFilename:[NSString stringWithFormat:@"mand%d0.png",i]];
    }

}
BOOL  isActivCharacter(int idx)
{
    if(getTotalScore()>=gChopForUnlock[idx] || getMaxScore()>=gScoreForUnlock[idx])
    {
        return true;

    }
    else
    {
        return false;

    }
    
}
void initGlobalVars()
{
    gScore=0;
    currentLevel=1;
    currentState=GSTATE_READY;
    gStrCharacter[0]=@"Red Shirt";
    gStrCharacter[1]=@"Green Shirt";
    gStrCharacter[2]=@"Timber Boy";
    gStrCharacter[3]=@"BaldHead";
    gStrCharacter[4]=@"Timber Girl";
    gStrCharacter[5]=@"Trapper";
    gStrCharacter[6]=@"Hazmat";
    gStrCharacter[7]=@"Sitting Wolf";
    gStrCharacter[8]=@"Flockey";
    gStrCharacter[9]=@"Jason";
    gStrCharacter[10]=@"Worker";
    gStrCharacter[11]=@"Mr.  Tree";
    gStrCharacter[12]=@"Sir Tim";
    gStrCharacter[13]=@"Dr.  Jones";
    gStrCharacter[14]=@"Dwarf";
    gStrCharacter[15]=@"Olaf";
    gStrCharacter[16]=@"Mr.  President";
    gStrCharacter[17]=@"Bulk";
    gStrCharacter[18]=@"Lazy Bird";
    gStrCharacter[19]=@"Red Shirt";
    
    gScoreForUnlock[0]=0;
    gScoreForUnlock[1]=100;
    gScoreForUnlock[2]=150;
    gScoreForUnlock[3]=200;
    gScoreForUnlock[4]=250;
    gScoreForUnlock[5]=300;
    gScoreForUnlock[6]=350;
    gScoreForUnlock[7]=400;
    gScoreForUnlock[8]=450;
    gScoreForUnlock[9]=500;
    gScoreForUnlock[10]=550;
    gScoreForUnlock[11]=600;
    gScoreForUnlock[12]=650;
    gScoreForUnlock[13]=700;
    gScoreForUnlock[14]=750;
    gScoreForUnlock[15]=800;
    gScoreForUnlock[16]=850;
    gScoreForUnlock[17]=900;
    gScoreForUnlock[18]=950;
    gScoreForUnlock[19]=1000;
    
    gChopForUnlock[0]=0;
    gChopForUnlock[1]=1000;
    gChopForUnlock[2]=2500;
    gChopForUnlock[3]=3000;
    gChopForUnlock[4]=4000;
    gChopForUnlock[5]=5000;
    gChopForUnlock[6]=7000;
    gChopForUnlock[7]=9000;
    gChopForUnlock[8]=10000;
    gChopForUnlock[9]=11000;
    gChopForUnlock[10]=13000;
    gChopForUnlock[11]=15000;
    gChopForUnlock[12]=17000;
    gChopForUnlock[13]=18000;
    gChopForUnlock[14]=19000;
    gChopForUnlock[15]=20000;
    gChopForUnlock[16]=30000;
    gChopForUnlock[17]=35000;
    gChopForUnlock[18]=40000;
    gChopForUnlock[19]=50000;
    
}

int   getMaxScore()
{
    NSUserDefaults    *defaults=[NSUserDefaults standardUserDefaults];
    int maxScore =[defaults integerForKey:KEY_MAX_SCORE];
    return maxScore;
}
int getTotalScore()
{
    NSUserDefaults    *defaults=[NSUserDefaults standardUserDefaults];
    int totalScore =[defaults integerForKey:KEY_TOTAL_SCORE];
    return totalScore;
}

void addTotalScore(int currentScore)
{
    NSUserDefaults    *defaults=[NSUserDefaults standardUserDefaults];
    int totalCurrent =[defaults integerForKey:KEY_TOTAL_SCORE];
    
    int  totalScore=totalCurrent+currentScore;
    [defaults setInteger:totalScore forKey:KEY_TOTAL_SCORE];
}