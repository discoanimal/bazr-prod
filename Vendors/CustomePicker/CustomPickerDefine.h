//
//  CustomPickerDefine.h
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#ifndef FSManager_CustomPickerDefine_h
#define FSManager_CustomPickerDefine_h

#define stringNilOrEmpty(a)                  (!a || ![a isKindOfClass:[NSString class]] || [a length] <= 0)

@protocol SelectorViewDelegate<NSObject>

- (void) okSelector : (long)index value: (NSString*)value;
@optional
- (void) cancelSelector;

@end

@protocol PickerSelectedDelegate

- (void) valueChanged : (long) index value:(NSString*)value;

@end

@protocol CustomPickerView

@property (nonatomic, readwrite) id<PickerSelectedDelegate> pickerDelegate;

- (void) setValues : (NSMutableArray*)values;
- (void) setValue : (NSString*)value;
- (NSString*) getValue;

@end


#endif
