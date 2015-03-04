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

- (IBAction)pressExpiration:(id)sender;

- (IBAction)onCategory:(id)sender;

- (IBAction)onCancel:(id)sender;
- (IBAction)onPost:(id)sender;

@end


@implementation PostView

@synthesize viewHeader;
@synthesize cellTitle, cellCategory, cellPayment, cellDescription;

@synthesize txtTitle, txtExpiraton, txtPayment, txtDescription;
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
        txtTitle.text = @"";
        txtDescription.text = @"";
        txtPayment.text = @"";
        categories = nil;
        txtExpiraton.text = @"Now";
        
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


//#pragma mark - UIImagePickerControllerDelegate
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    UIImage *image = info[UIImagePickerControllerEditedImage];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    if (image.size.width > 140) image = ResizeImage(image, 140, 140);
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    PFFile *filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
//    [filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//     {
//         if (error != nil) [ProgressHUD showError:@"Network error."];
//     }];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    imageUser.image = image;
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    if (image.size.width > 30) image = ResizeImage(image, 30, 30);
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    PFFile *fileThumbnail = [PFFile fileWithName:@"thumbnail.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
//    [fileThumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//     {
//         if (error != nil) [ProgressHUD showError:@"Network error."];
//     }];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    PFUser *user = [PFUser currentUser];
//    user[PF_USER_PICTURE] = filePicture;
//    user[PF_USER_THUMBNAIL] = fileThumbnail;
//    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//     {
//         if (error != nil) [ProgressHUD showError:@"Network error."];
//     }];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//

#pragma mark - Table view data source

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
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

#pragma mark - UIActionSheetDelegate
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    if (buttonIndex != actionSheet.cancelButtonIndex)
//    {
//        [PFUser logOut];
//        ParsePushUserResign();
//        PostNotification(NOTIFICATION_USER_LOGGED_OUT);
//
//        imageUser.image = [UIImage imageNamed:@"blank_profile"];
//        fieldName.text = @"";
//
//        LoginUser(self);
//    }
//}
//

#pragma mark - CategoryDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) onSelectCategory : (NSMutableDictionary*)cates
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    categories = cates;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

#pragma mark - SelectorViewDelegate
- (void) okSelector : (long)index value: (NSString*)value
{
    txtExpiraton.text = value;
}

#pragma mark - User actions

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)pressExpiration:(id)sender {
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
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)onPost:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [ProgressHUD show:nil];
    PFObject *object = [PFObject objectWithClassName:PF_CHATROOMS_CLASS_NAME];
    object[PF_CHATROOMS_NAME] = txtTitle.text;
    object[PF_CHATROOMS_DESCRIPTION] = txtDescription.text;
//    object[PF_POSTS_PAYMENTKEY] = txtPayment.text;
    
    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
     {
         if (error == nil)
         {
//          goto collaction view
         }
         else
             [ProgressHUD showError:@"Network error."];
         [ProgressHUD dismiss];
     }];

}
@end
