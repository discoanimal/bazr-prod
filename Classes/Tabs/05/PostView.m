//
//  PostView.m
//  bazr
//
//  Created by Justin Lynch on 1/28/15.
//  Copyright (c) 2015 KZ. All rights reserved.
//


#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppDelegate.h"
#import "AppConstant.h"
#import "camera.h"
#import "pushnotification.h"
#import "utilities.h"

#import "CategoryView.h"
#import "PostView.h"
#import "MFSideMenu.h"

#import "MIActionSheet.h"

@interface PostView ()
{
    NSMutableArray      *aryCateItems;
    NSMutableDictionary *categories;
    
    MIActionSheet*      actionSheet;
    MIDatePickerView*   datePicker;

    NSDate *            postDate;
    NSDate *            expireDate;
}
@property (strong, nonatomic) IBOutlet UIView *viewHeader;

@property (strong, nonatomic) IBOutlet UITableViewCell *cellTitle;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellCategory;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellPayment;
@property (strong, nonatomic) IBOutlet UITableViewCell *cellDescription;
@property (weak, nonatomic) IBOutlet UIButton *btnPost;


@property (weak, nonatomic) IBOutlet UITextField *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtExpiraton;
@property (weak, nonatomic) IBOutlet UITextField *txtPayment;
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (weak, nonatomic) IBOutlet UILabel *txtCategories;
@property (weak, nonatomic) IBOutlet UIView *vwCategories;


- (IBAction)pressExpiration:(id)sender;

- (IBAction)onCategory:(id)sender;

- (IBAction)onCancel:(id)sender;
- (IBAction)onPost:(id)sender;

@end


@implementation PostView

@synthesize viewHeader;
@synthesize cellTitle, cellCategory, cellPayment, cellDescription;
@synthesize txtTitle, txtExpiraton, txtPayment, txtDescription,txtCategories;
@synthesize vwCategories;

//
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)aDecoder
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab_post"]];
        self.tabBarItem.title = @"";
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.title = nil;
        
    }
    return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_post"]];
       
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
    
    self.tableView.tableHeaderView = viewHeader;
    
    actionSheet = [[MIActionSheet alloc]init];
    actionSheet.delegate = self;
    datePicker = [[MIDatePickerView alloc] init];

    aryCateItems = [[NSMutableArray alloc] init];
    //---------------------------------------------------------------------------------------------------------------------------------------------
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] != nil)
    {
        [self dismissKeyboard];
        txtTitle.text = @"";
        txtDescription.text = @"";
        txtPayment.text = @"";
        categories = nil;
        txtExpiraton.text = @"Now";
        [self removeCategoryItems];
        
        postDate = [[NSDate alloc] init];
        expireDate = [[NSDate alloc] initWithTimeInterval:3600 sinceDate:postDate];
    }
    else LoginUser(self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)dismissKeyboard
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.view endEditing:YES];
}

#define LABEL_HEIGHT    30
#define LABEL_WIDTH     60
#define LABEL_GAP       20

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) addCategoryItem:(NSString*) strValue color:(UIColor*)backColor
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    CGRect vwframe = vwCategories.frame;
    NSInteger posY = 0;
    
    UILabel *lastLabel = nil;
    
    if ([aryCateItems count] > 0)
        lastLabel = [aryCateItems objectAtIndex:[aryCateItems count] - 1];
    
    NSInteger posX = (lastLabel)?lastLabel.frame.origin.x + lastLabel.frame.size.width + LABEL_GAP:0;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(posX, posY, LABEL_WIDTH, LABEL_HEIGHT)];
    
    label.text = strValue;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = backColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5;//LABEL_HEIGHT / 2;
//    [label sizeToFit];
    
    CGRect frame = label.frame;
    posY = vwframe.origin.y + (vwframe.size.height / 2) - frame.size.height / 2;
    frame.origin.y = posY;
    label.frame = frame;
    
    [aryCateItems addObject:label];
    [vwCategories addSubview:label];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) removeCategoryItems
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    UILabel *label;
    
    for (label in aryCateItems) {
        [label removeFromSuperview];
    }
    [aryCateItems removeAllObjects];
}

#pragma mark - UITextFieldDelegate

#define TITLE_MAXLENGTH 32

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSUInteger maxLength;
 
    if (textField == txtTitle)
        maxLength = TITLE_MAXLENGTH;
    else if (textField == txtPayment)
        maxLength = 4;
    else if (textField == txtDescription)
        maxLength = 1024;
    
    if (textField.text.length >= maxLength && range.length == 0)
        return NO;
    
//    if (textField == txtPayment)
//    {
//        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//        
//        if ([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound)
//        {
//            return NO;
//        }
//    }
    
    return YES;
}

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
//    if (indexPath.row == 3) return 100;
    
    return 64;
}
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 1;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return 4;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (indexPath.row == 0) return cellTitle;
    if (indexPath.row == 1) return cellCategory;
    if (indexPath.row == 2) return cellPayment;
    if (indexPath.row == 3) return cellDescription;
    return nil;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - CategoryDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) onSelectCategory : (NSMutableDictionary*)cates
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    categories = cates;
 
    [self removeCategoryItems];
    if (!categories) return;
    
    if ([categories count] <= 0)
    {
        [self addCategoryItem:@"All" color:[UIColor redColor]];
    }
    else
    {
        NSString *strKey, *strCaption;

//        txtCategories.text = @"";
        for (NSObject *obj in categories) {
            strKey  = (NSString*)obj;
            strCaption = [categories objectForKey:strKey];
            
#if 0
            if ([txtCategories.text length] > 0)
                txtCategories.text= [NSString stringWithFormat:@"%@, %@", txtCategories.text, strCaption];
            else
                txtCategories.text = strCaption;
#else
            [self addCategoryItem:strCaption color:[UIColor blueColor]];
#endif
        }
    }
    
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

#pragma mark - SelectorViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) okSelector : (long)index value: (NSString*)value
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    txtExpiraton.text = value;
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)pressExpiration:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [datePicker setMinimumDate:postDate];
    
    [actionSheet setPickerValue:(UIPickerView<CustomPickerView>*)datePicker value:txtExpiraton.text];
    [actionSheet showActionSheet];
}

- (IBAction)onCategory:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    CategoryView *catView = [CategoryView shareInstance];
    
    catView.delegate = self;
    [catView showCategoryView:categories];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)onCancel:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self.tabBarController.selectedIndex = 0;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)onPost:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    if (stringNilOrEmpty(txtTitle.text))
    {
        [txtTitle becomeFirstResponder];
        [ProgressHUD showError:@"Title is empty."];
        return;
    }
    if (!categories)
    {
//        [txtPayment becomeFirstResponder];
        [self onCategory:nil];
        [ProgressHUD showError:@"Category is not selected."];
        return;
    }
    if (stringNilOrEmpty(txtPayment.text))
    {
        [txtPayment becomeFirstResponder];
        [ProgressHUD showError:@"Payment is empty."];
        return;
    }
    if (stringNilOrEmpty(txtDescription.text))
    {
        [txtDescription becomeFirstResponder];
        [ProgressHUD showError:@"Description is empty."];
        return;
    }
    
    [ProgressHUD show:nil];
    PFObject *object = [PFObject objectWithClassName:PF_CHATROOMS_CLASS_NAME];
    
    object[PF_CHATROOMS_NAME] = txtTitle.text;
    object[PF_CHATROOMS_DESCRIPTION] = txtDescription.text;
//    object[PF_POSTS_PAYMENTKEY] = txtPayment.text;
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error == nil)
         {

         }
         else
             [ProgressHUD showError:@"Network error."];
         
         self.tabBarController.selectedIndex = 0;
         [ProgressHUD dismiss];
     }];
}
@end
