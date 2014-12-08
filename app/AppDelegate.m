
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "AppConstant.h"
#import "utilities.h"
#import "AppDelegate.h"
#import "GroupView.h"
#import "PrivateView.h"
#import "MessagesView.h"
#import "ProfileView.h"
#import "NavigationController.h"

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
	
	self.groupView = [[GroupView alloc] init];
	self.privateView = [[PrivateView alloc] init];
	self.messagesView = [[MessagesView alloc] init];
	self.profileView = [[ProfileView alloc] init];
	
	NavigationController *navController1 = [[NavigationController alloc] initWithRootViewController:self.groupView];
	NavigationController *navController2 = [[NavigationController alloc] initWithRootViewController:self.privateView];
	NavigationController *navController3 = [[NavigationController alloc] initWithRootViewController:self.messagesView];
	NavigationController *navController4 = [[NavigationController alloc] initWithRootViewController:self.profileView];

	self.tabBarController = [[UITabBarController alloc] init];
	self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1, navController2, navController3, navController4, nil];
	self.tabBarController.tabBar.translucent = NO;
	self.tabBarController.selectedIndex = 0;

	self.window.rootViewController = self.tabBarController;
	[self.window makeKeyAndVisible];
	//---------------------------------------------------------------------------------------------------------------------------------------------
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

@end
