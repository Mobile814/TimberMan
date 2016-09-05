//
//  AppDelegate.m
//  Timber Man
//
//  Created by Jin on 7/12/14.
//  Copyright Jin 2014. All rights reserved.
//

#import "cocos2d.h"
#import "Global.h"
#import "AppDelegate.h"

@implementation MyNavigationController

// The available orientations should be defined in the Info.plist file.
// And in iOS 6+ only, you can override it in the Root View controller in the "supportedInterfaceOrientations" method.
// Only valid for iOS 6+. NOT VALID for iOS 4 / 5.
-(NSUInteger)supportedInterfaceOrientations {
	
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskPortrait;
	
	// iPad only
	return UIInterfaceOrientationMaskPortrait;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	
	// iPad only
	// iPhone only
	return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

// This is needed for iOS4 and iOS5 in order to ensure
// that the 1st scene has the correct dimensions
// This is not needed on iOS6 and could be added to the application:didFinish...
-(void) directorDidReshapeProjection:(CCDirector*)director
{
	if(director.runningScene == nil) {
		// Add the first scene to the stack. The director will draw it immediately into the framebuffer. (Animation is started automatically when the view is displayed.)
		// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
		
	}
}
@end


@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [self initGameCenter];
    [self defaultAction];
    initAnims();
    [self treateScaleR];
    initAnims();
    [[CCDirector sharedDirector] runWithScene:[MenuLayer node]];
	
	return YES;
}


- (void) preloadInterstitial
{
    interstitial_ = [[GADInterstitial alloc] init];
    interstitial_.adUnitID = ADMOB_ID;//@"ca-app-pub-6046034785851961/xxxxxx";
    interstitial_.delegate = self;
    //[interstitial_ presentFromRootViewController:navController_];
    [interstitial_ loadRequest:[GADRequest request]];
    
}

- (void) interstitialDidReceiveAd:(GADInterstitial *)ad
{
    
    //[interstitial_ presentFromRootViewController:navController_];
    
    
}
- (void) interstitialDidDismissScreen:(GADInterstitial *)ad
{
    [self preloadInterstitial];
}

-(void)showAdmobInterstitial
{
    [interstitial_ presentFromRootViewController:navController_];
}
- (void) interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error
{
    [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(preloadInterstitial) userInfo:Nil repeats:NO];
}


-(void)registerChartboost
{
    Chartboost *cb = [Chartboost sharedChartboost];
    cb.appId = CHARTBOOST_APP_ID;
    cb.appSignature = CHARTBOOST_APP_SIGNATURE;
    [cb startSession];
    [cb cacheInterstitial];
    [cb cacheMoreApps];
}




- (BOOL)initGameCenter {
    
	if(self.gameCenterManager != nil)
		return NO;
    self.currentLeaderBoard = LEADERBOARD_ID;
    
	if ([GameCenterManager isGameCenterAvailable])
	{
		self.gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
		[self.gameCenterManager setDelegate:self];
		[self.gameCenterManager authenticateLocalUser];
        return YES;
	}
    else
    {
        NSString *message = @"This IOS version is not available Game Center.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message!" message:message delegate:self cancelButtonTitle:@"YES" otherButtonTitles: nil];
        alert.tag = 1;
        [alert show];
        [alert release];
    }
    
    return NO;
}

- (void) showLeaderboard{
	GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
	if (leaderboardViewController != NULL) {
		leaderboardViewController.category = self.currentLeaderBoard;
		leaderboardViewController.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboardViewController.leaderboardDelegate = self;
        
        [self.navController presentModalViewController:leaderboardViewController animated:YES];
        
	}
}

- (void) showAchievements{
	GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	if (achievements != NULL){
		achievements.achievementDelegate = self;
		[self.navController presentModalViewController: achievements animated: YES];
	}
}

- (void)submitScore: (int) uploadScore{
	if( uploadScore > 0){
        
        if ([GameCenterManager isGameCenterAvailable]) {
            [self.gameCenterManager reportScore:uploadScore  forCategory: self.currentLeaderBoard];
            [self.gameCenterManager reloadHighScoresForCategory:self.currentLeaderBoard];
        }
	}
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	[self.navController dismissModalViewControllerAnimated:YES];
    [viewController release];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[self.navController dismissModalViewControllerAnimated:YES];
    [viewController release];
}

#pragma makr GameCenterManager protocol

- (void) scoreReported: (NSError*) error
{
    NSString *message = @"Score submited succesfully to Game Center.";
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations!" message:message delegate:self cancelButtonTitle:@"YES" otherButtonTitles: nil];
    //    alert.tag = 1;
    //    [alert show];
    //    [alert release];
    NSLog(@"%@", message);
}

- (void) processGameCenterAuth: (NSError*) error
{
    if (error == NULL) {
        NSLog(@"Game Center Auth success!");
    }
    else {
        NSLog(@"Game Center Auth faild!");
    }
}

- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error
{
    if (error == NULL) {
        NSLog(@"Game Center reload socores success!");
    }
    else {
        NSLog(@"Game Center reload socores faild!");
    }
}




+(AppController*) get
{
	return (AppController*) [[UIApplication sharedApplication] delegate];
}






-(void)treateScaleR
{
    if (CC_CONTENT_SCALE_FACTOR() == 2)
        g_fScaleR = 2.0f;
}



-(void)defaultAction
{
    window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	
	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
	
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
	
	director_.wantsFullScreenLayout = YES;
	
	// Display FSP and SPF
	[director_ setDisplayStats:false];
	
	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];
	
	// attach the openglView to the director
	[director_ setView:glView];
    [glView setMultipleTouchEnabled:true];
	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
	//	[director setProjection:kCCDirectorProjection3D];
	
	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change this setting at any time.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
	
	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
	
	// Create a Navigation Controller with the Director
	navController_ = [[MyNavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
    
	// for rotation and other messages
	[director_ setDelegate:navController_];
	
	// set the Navigation Controller as the root view controller
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
}


















// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
    [self registerChartboost];
    [self preloadInterstitial];
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	
	[super dealloc];
}
@end
