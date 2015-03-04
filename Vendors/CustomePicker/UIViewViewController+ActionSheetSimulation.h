//
//  UIViewViewController+ActionSheetSimulation.h
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPickerDefine.h"

@interface UIViewController (ActionSheetSimulation)

-(UIView*) actionSheetSimulationWithPickerView:(UIPickerView*)pickerView withToolbar: (UIToolbar*)pickerToolbar;
-(UIView*) actionSheetSimulationWithPickerView:(UIView*)view;

-(void)dismissActionSheetSimulation;

@end
