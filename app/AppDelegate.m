
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AppConstant.h"
#import "utilities.h"
#import "AppDelegate.h"
#import "GroupView.h"
#import "PrivateView.h"
#import "MessagesView.h"
#import "ProfileView.h"
#import "PostView.h"
#import "NavigationController.h"
#import "FontAwesomeKit.h"
#import "MFSideMenuContainerViewConroller+TabViewDelegate.h"

#define USE_TAB_POST

@implementation AppDelegate

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[Parse setApplicationId:@"xNdQFsbz5yM3CGrg17zZJBIfZAqzX60Jo46qAGb9" clientKey:@"5ilkTjGLHPbovOauelVw0SRuUvyx5Gumlw0grmFU"];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[PFFacebookUtils initializeFacebook];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
	{
		UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);
		UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes categories:nil];
		[application registerUserNotificationSettings:settings];
		[application registerForRemoteNotifications];
	}
	//---------------------------------------------------------------------------------------------------------------------------------------------
	[PFImageView class];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
	
	self.groupView = [[UIStoryboard storyboardWithName:@"GroupView" bundle:nil] instantiateViewControllerWithIdentifier:@"GroupView"];
	self.privateView = [[PrivateView alloc] init];
	self.messagesView = [[MessagesView alloc] init];
	self.profileView = [[ProfileView alloc] init];
#ifdef USE_TAB_POST
    self.postView = [[UIStoryboard storyboardWithName:@"PostView" bundle:nil] instantiateViewControllerWithIdentifier:@"PostView"];
#endif
    
	NavigationController *navController1 = [[NavigationController alloc] initWithRootViewController:self.groupView];
	NavigationController *navController2 = [[NavigationController alloc] initWithRootViewController:self.privateView];
	NavigationController *navController3 = [[NavigationController alloc] initWithRootViewController:self.messagesView];
	NavigationController *navController4 = [[NavigationController alloc] initWithRootViewController:self.profileView];
#ifdef USE_TAB_POST
    NavigationController *navController5 = [[NavigationController alloc] initWithRootViewController:self.postView];
#endif
    
	self.tabBarController = [[UITabBarController alloc] init];
#ifndef USE_TAB_POST
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, navController4, nil];
#else
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController5, navController3, navController4, nil];
#endif
    self.tabBarController.tabBar.translucent = NO;
	self.tabBarController.selectedIndex = 0;
    
    // set the bar background color
//    UIColor *backgroundColor = [UIColor greenColor];
//    [[UITabBar appearance] setBackgroundImage:[AppDelegate imageFromColor:backgroundColor forSize:CGSizeMake(320, 49) withCornerRadius:0]];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"TabBarBG"]];

    
    // set the text color for selected state
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    // set the text color for unselected state
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    // set the selected icon color
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    // remove the shadow
    [[UITabBar appearance] setShadowImage:nil];
    
    // Set the dark color to selected tab (the dimmed background)
    
    CGFloat tabWidth = self.window.frame.size.width / self.tabBarController.viewControllers.count;
    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor colorWithRed:19/255.0 green:19/255.0 blue:19/255.0 alpha:0.8] forSize:CGSizeMake(tabWidth, 49) withCornerRadius:0]];
    
    
    
    UISplitViewController *settingsViewController = [[UISplitViewController alloc] init];
    UINavigationController *settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
    
    // LOOK AT THIS
    settingsNavigationController.tabBarItem.image = [[UIImage imageNamed:@"IconSetting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    

    UIViewController *catView = [[UIStoryboard storyboardWithName:@"PostView" bundle:nil] instantiateViewControllerWithIdentifier:@"CategoryView"];
    
    MFSideMenuContainerViewConrollerTabView *container = [MFSideMenuContainerViewConrollerTabView containerWithCenterViewController:self.tabBarController leftMenuViewController:nil rightMenuViewController:nil];
    
    self.tabBarController.delegate = container;

    [container setRightMenuViewController:catView];
    [container setMenuWidth:120];
    
	self.window.rootViewController = container;
	[self.window makeKeyAndVisible];
	
    
	return YES;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillResignActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidEnterBackground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillEnterForeground:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationDidBecomeActive:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)applicationWillTerminate:(UIApplication *)application
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	
}

#pragma mark - Facebook responses

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:[PFFacebookUtils session]];
}

#pragma mark - Push notification methods

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	PFInstallation *currentInstallation = [PFInstallation currentInstallation];
	[currentInstallation setDeviceTokenFromData:deviceToken];
	[currentInstallation saveInBackground];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	NSLog(@"didFailToRegisterForRemoteNotificationsWithError %@", error);
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self performSelector:@selector(refreshMessagesView) withObject:nil afterDelay:4.0];
	//---------------------------------------------------------------------------------------------------------------------------------------------
	//[PFPush handlePush:userInfo];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)refreshMessagesView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[self.messagesView loadMessages];
}


// UIColor into Image
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end
