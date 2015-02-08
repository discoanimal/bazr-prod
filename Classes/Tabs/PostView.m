//
//  PostView.m
//  bazr
//
//  Created by Justin Lynch on 1/28/15.
//  Copyright (c) 2015 KZ. All rights reserved.
//


#import <Parse/Parse.h>
#import "ProgressHUD.h"

#import "AppConstant.h"
#import "camera.h"
#import "pushnotification.h"
#import "utilities.h"

#import "PostView.h"

@interface PostView ()
//@property (strong, nonatomic) IBOutlet UIView *viewHeader;
//@property (strong, nonatomic) IBOutlet PFImageView *imageUser;
//
//@property (strong, nonatomic) IBOutlet UITableViewCell *cellName;
//@property (strong, nonatomic) IBOutlet UITableViewCell *cellButton;
//
//@property (strong, nonatomic) IBOutlet UITextField *fieldName;

@end


@implementation PostView

//@synthesize viewHeader, imageUser;
//@synthesize cellName, cellButton;
//@synthesize fieldName;
//
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab_post"]];
        self.tabBarItem.title = @"";
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.title = nil;
        
    }
    return self;
}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)viewDidLoad
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    [super viewDidLoad];
//    self.title = @"";
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Log out" style:UIBarButtonItemStylePlain target:self
//                                                                             action:@selector(actionLogout)];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)]];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    self.tableView.tableHeaderView = viewHeader;
//    self.tableView.separatorInset = UIEdgeInsetsZero;
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    imageUser.layer.cornerRadius = imageUser.frame.size.width / 2;
//    imageUser.layer.masksToBounds = YES;
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)viewDidAppear:(BOOL)animated
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    [super viewDidAppear:animated];
//    //---------------------------------------------------------------------------------------------------------------------------------------------
//    if ([PFUser currentUser] != nil)
//    {
//        [self profileLoad];
//    }
//    else LoginUser(self);
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)dismissKeyboard
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    [self.view endEditing:YES];
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)profileLoad
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    PFUser *user = [PFUser currentUser];
//    
//    [imageUser setFile:user[PF_USER_PICTURE]];
//    [imageUser loadInBackground];
//    
//    fieldName.text = user[PF_USER_FULLNAME];
//}
//
//#pragma mark - User actions
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (void)actionLogout
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
//                                               otherButtonTitles:@"Log out", nil];
//    [action showFromTabBar:[[self tabBarController] tabBar]];
//}
//
//#pragma mark - UIActionSheetDelegate
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
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (IBAction)actionPhoto:(id)sender
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    ShouldStartPhotoLibrary(self, YES);
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (IBAction)actionSave:(id)sender
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    [self dismissKeyboard];
//    
//    if ([fieldName.text isEqualToString:@""] == NO)
//    {
//        [ProgressHUD show:@"Please wait..."];
//        
//        PFUser *user = [PFUser currentUser];
//        user[PF_USER_FULLNAME] = fieldName.text;
//        user[PF_USER_FULLNAME_LOWER] = [fieldName.text lowercaseString];
//        
//        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
//         {
//             if (error == nil)
//             {
//                 [ProgressHUD showSuccess:@"Saved."];
//             }
//             else [ProgressHUD showError:@"Network error."];
//         }];
//    }
//    else [ProgressHUD showError:@"Name field must be set."];
//}
//
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
//#pragma mark - Table view data source
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    return 2;
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    return 1;
//}
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
////-------------------------------------------------------------------------------------------------------------------------------------------------
//{
//    if (indexPath.section == 0) return cellName;
//    if (indexPath.section == 1) return cellButton;
//    return nil;
//}
//
//@end


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
