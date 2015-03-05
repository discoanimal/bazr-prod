//
//  MFSideMenuContainerViewConroller+TabViewDelegate.m
//  bazr
//
//  Created by a on 3/4/15.
//  Copyright (c) 2015 KZ. All rights reserved.
//

#import "MFSideMenuContainerViewConroller+TabViewDelegate.h"

@interface MFSideMenuContainerViewConrollerTabView ()

@end

@implementation MFSideMenuContainerViewConrollerTabView

+ (MFSideMenuContainerViewConrollerTabView *)containerWithCenterViewController:(id)centerViewController
                                                  leftMenuViewController:(id)leftMenuViewController
                                                 rightMenuViewController:(id)rightMenuViewController {
    MFSideMenuContainerViewConrollerTabView *controller = [MFSideMenuContainerViewConrollerTabView new];
    controller.leftMenuViewController = leftMenuViewController;
    controller.centerViewController = centerViewController;
    controller.rightMenuViewController = rightMenuViewController;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITabBarControllerDelegate Methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController
{
    if (super.menuState == MFSideMenuStateClosed)
        return YES;
    
    return NO;
}

@end
