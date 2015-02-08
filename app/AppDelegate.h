
#import <UIKit/UIKit.h>
#import "GroupView.h"
#import "PrivateView.h"
#import "MessagesView.h"
#import "ProfileView.h"
#import "PostView.h"
#import "FAKFontAwesome.h"
#import "FAKFoundationIcons.h"
#import "FAKZocial.h"
#import "FAKIonIcons.h"

//-------------------------------------------------------------------------------------------------------------------------------------------------
@interface AppDelegate : UIResponder <UIApplicationDelegate>
//-------------------------------------------------------------------------------------------------------------------------------------------------

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) GroupView *groupView;
@property (strong, nonatomic) PrivateView *privateView;
@property (strong, nonatomic) MessagesView *messagesView;
@property (strong, nonatomic) ProfileView *profileView;
@property (strong, nonatomic) PostView *postView;

@end
