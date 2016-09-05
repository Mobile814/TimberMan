//
//  GameEndLayer.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright 2014 Jin. All rights reserved.
//

#import "GameEndLayer.h"
#import "Global.h"

@implementation GameEndLayer
+(CCScene *) scene
{
    CCScene *scene = [CCScene node];
    GameEndLayer *layer = [GameEndLayer node];
    [scene addChild:layer];
    return scene;
}
-(id)init
{
    if(self==[super init])
    {
        gameEndLayer=self;
        [self createBackground];
        [self createMenu];
        [self initLabel];
        [self treateAds];
    }
    return self;
}
-(void)treateAds
{
    [[Chartboost sharedChartboost]showInterstitial];
    [[AppController get]showAdmobInterstitial];
}
-(void)createBackground
{
    sprOverBoard=newSpritePosA(@"bgOver", POS_SCOREBOARD, self, Z_BACK, RATIO_XY, 1.0);
    [sprOverBoard setAnchorPoint:ccp(0.5,1)];
}
-(void)createMenu
{
    
    btnPlay=newButtonPosA(@"Play",         POS_BTN_PLAY,  self, @selector(onClickPlay),  false, RATIO_X, F_SCALE_BTN);
    btnScore=newButtonPosA(@"Leaderboard", POS_BTN_SCORE, self, @selector(onClickScore), false, RATIO_X, F_SCALE_BTN);
    btnShop=newButtonPosA(@"Shop",         POS_BTN_SHOP,  self, @selector(onClickShop), false, RATIO_X, F_SCALE_BTN);
    btnTW=newButtonPosA(@"TW",         POS_BTN_TW,  self, @selector(onClickTW), false, RATIO_X, F_SCALE_BTN);
    menu=[CCMenu  menuWithItems:btnPlay,btnScore,btnShop,btnTW, nil];
    [menu setPosition:ccp(0,0)];
    [self addChild:menu z:Z_BTN];
}
-(void)initLabel
{
    lblBest=newLabel(self, @"Best", FNT_NAME, 50, ccc3(88, 54, 31), POS_SPR_BEST);
    lblBestVal=newLabel(self,[NSString stringWithFormat:@"%d",[self treateScore]], FNT_NAME, 50, ccWHITE, POS_SPR_BEST_VAL);
    lblScore=newLabel(self, @"Score", FNT_NAME, 50, ccc3(88, 54, 31), POS_SPR_SCORE);
    lblScoreVal=newLabel(self,[NSString stringWithFormat:@"%d",gScore], FNT_NAME, 50, ccWHITE, POS_SPR_SCORE_VAL);
    lblShare=newLabel(self, @"Share", FNT_NAME, 50, ccc3(88, 54, 31), POS_SPR_SHARE);


}
-(int)treateScore
{
    NSUserDefaults    *defaults=[NSUserDefaults standardUserDefaults];
    int maxScore =[defaults integerForKey:KEY_MAX_SCORE];
    if(maxScore<gScore)
    {
        maxScore=gScore;
        [defaults setInteger:maxScore forKey:KEY_MAX_SCORE];
        
    }
   
    addTotalScore(gScore);
    return maxScore;
}

-(void)moveDownAnim
{
    
}
-(void)onClickTW
{
    [[SimpleAudioEngine sharedEngine]playEffect:@"click.mp3"];
    NSString *scoreString=[NSString stringWithFormat:@"Please check this Game: GAME_LINK"];
    UIImage *img = [self screenshotWithStartNode:self filename:@"Screen.png"];
    [self shareTwitter:img :scoreString];
}





//***Social Function
-(UIImage *) screenshotWithStartNode:(CCNode*)startNode filename:(NSString*)filename

{
    
    //name the file we want to save in documents
    NSString* file = @"//imageforphotolib.png";
    
    //get the path to the Documents directory
    NSArray* paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* screenshotPath = [documentsDirectory stringByAppendingPathComponent:file];
    
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCRenderTexture* rtx =
    [CCRenderTexture renderTextureWithWidth:winSize.width
                                     height:winSize.height];
    [rtx begin];
    [startNode visit];
    [rtx end];
    
    // save as file as PNG
    [rtx  saveToFile:@"imageforphotolib.png"  format:kCCImageFormatPNG];
    
    //get the screenshot as raw data
    NSData *data = [NSData dataWithContentsOfFile:screenshotPath];
    //create an image from the raw data
    UIImage *img = [UIImage imageWithData:data];
    return img;
}


-(void)shareFB:(UIImage *)img :(NSString *)text
{
    //if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [controller setInitialText:text];
    //[controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
    if(img)
        [controller addImage:img];
    
    [[CCDirector sharedDirector]presentViewController:controller animated:YES completion:nil];
    // }
}

-(void)shareTwitter:(UIImage *)img :(NSString *)text
{
    // if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [controller setInitialText:text];
    //[controller addURL:[NSURL URLWithString:@"http://www.appcoda.com"]];
    if(img)
        [controller addImage:img];
    
    [[CCDirector sharedDirector]presentViewController:controller animated:YES completion:nil];
    // }
}










-(void)onClickPlay
{
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
    [gameLayer hideSubLayerAnim];
   
}
-(void)onClickScore
{
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
    [[AppController get]showLeaderboard];
}
-(void)onClickShop
{
    [gameLayer gotoShopLayer];
    [[SimpleAudioEngine sharedEngine]playEffect:@"click1.wav"];
}

@end
