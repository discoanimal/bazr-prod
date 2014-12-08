

#import "AppConstant.h"

#import "NavigationController.h"

@implementation NavigationController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
	[super viewDidLoad];

	self.navigationBar.barTintColor = HEXCOLOR(0x2C2C2C00);
	self.navigationBar.tintColor = [UIColor whiteColor];
	self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
	self.navigationBar.translucent = NO;
}

@end
