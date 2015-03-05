//
//  CarNumberActionSheet.m
//  FSManager
//
//  Created by ChoeMI on 2/21/15.
//  Copyright (c) 2015 damy. All rights reserved.
//

#import "MIActionSheet.h"

#define COLOR_TEXT          [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]
#define COLOR_BACKGROUND    [UIColor whiteColor]

#define BUTTON_WIDTH        80
#define BAR_HEIGHT          64
#define PICKER_HEIGHT       162
#define WIDTH               UIScreen.mainScreen.bounds.size.width
#define HEIGHT              PICKER_HEIGHT + BAR_HEIGHT

//#define CAPTION_CANCEL      @"取消"
//#define CAPTION_OK          @"完成"

#define CAPTION_CANCEL      @"Cancel"
#define CAPTION_OK          @"OK"

@implementation MIActionSheet
{
    UIView*                         view;
    UILabel *                       strCaption;
    UIPickerView<CustomPickerView>* picker;
}

@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) init
{
    self = [super init];
    
    strCaption = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 46)];
    [strCaption setTextAlignment:NSTextAlignmentCenter];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 46)];
    //    [imgView setBackgroundColor:[UIColor clearColor]];
    [imgView setImage:[UIImage imageNamed:@"title_bar.png"]];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 6, BUTTON_WIDTH, 30)];
    [cancelBtn setTitle:CAPTION_CANCEL forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(onCanceled:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius = 5;
    
    UIButton *okBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH -  BUTTON_WIDTH - 20, 6, BUTTON_WIDTH, 30)];
    [okBtn setTitle:CAPTION_OK forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor whiteColor]];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(onSelected:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.layer.cornerRadius = 5;
    
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    view.backgroundColor = [UIColor clearColor];
    
    [view addSubview:imgView];
    [view addSubview:strCaption];
    [view addSubview:cancelBtn];
    [view addSubview:okBtn];
    
    return self;
}

- (void) setPickerValue : (UIPickerView<CustomPickerView>*)_picker value : (NSString*) value
{
    picker = _picker;
    [picker setFrame:CGRectMake(0, 46, WIDTH, PICKER_HEIGHT)];
    
//    picker.showsSelectionIndicator = YES;
    picker.backgroundColor = [UIColor whiteColor];

    picker.pickerDelegate = self;
//    [picker initWithValues:nil];
    [picker setValue:value];
     [view addSubview:picker];
    
    [strCaption setText:[picker getValue]];
}

- (void) showActionSheet
{
    [self actionSheetSimulationWithPickerView:view];
}

- (void) setValue : (NSString*) value
{
    if (!picker) return ;
    
    [picker setValue : value];
    [strCaption setText : value];
}

#pragma mark - PickerSelectedDelegate
- (void) valueChanged : (long) index value:(NSString*)value
{
    [strCaption setText:value];
}

#pragma mark - Event Handler

- (void) onSelected : (id)sender
{
    long index = 0;
    if ([picker isKindOfClass:[MIObjectPickerView class]] || [picker isKindOfClass:[MIStringPickerView class]])
        index = [picker selectedRowInComponent:0];
    
    if (![picker getValue])
        return;
    [delegate okSelector:index value:[picker getValue]];
    [self dismissActionSheetSimulation];
}

- (void) onCanceled : (id)sender
{
    if ([delegate respondsToSelector:@selector(cancelSelector)])
        [delegate cancelSelector];
    
    [self dismissActionSheetSimulation];
}


@end
