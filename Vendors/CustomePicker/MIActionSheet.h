//
//  CarNumberActionSheet.h
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewViewController+ActionSheetSimulation.h"
#import "CustomPickerDefine.h"
#import "MIStringPickerView.h"
#import "MIObjectPickerView.h"
#import "MIDatePickerView.h"

@interface MIActionSheet : UIViewController<PickerSelectedDelegate>

@property (nonatomic, readwrite) id<SelectorViewDelegate> delegate;

- (void) setPickerValue : (UIPickerView<CustomPickerView>*)picker value : (NSString*) value;
- (void) showActionSheet;
- (void) setValue : (NSString*) value;
@end
