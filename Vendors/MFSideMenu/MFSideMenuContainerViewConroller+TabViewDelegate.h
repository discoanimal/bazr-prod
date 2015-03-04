//
//  MFSideMenuContainerViewConroller+TabViewDelegate.h
//  bazr
//
//  Created by a on 3/4/15.
//  Copyright (c) 2015 KZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFSideMenu.h"

@interface MFSideMenuContainerViewConrollerTabView : MFSideMenuContainerViewController<UITabBarControllerDelegate>

+ (MFSideMenuContainerViewConrollerTabView *)containerWithCenterViewController:(id)centerViewController
                                                  leftMenuViewController:(id)leftMenuViewController
                                                       rightMenuViewController:(id)rightMenuViewController;
@end
