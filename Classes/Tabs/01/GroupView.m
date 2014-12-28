
#import <Parse/Parse.h>
#import "ProgressHUD.h"
#import "AppConstant.h"
#import "messages.h"
#import "utilities.h"
#import "GroupView.h"
#import "ChatView.h"
#import "CSCell.h"
#import "CSStickyHeaderFlowLayout.h"

#define METERS_TO_FEET  3.2808399
#define METERS_TO_MILES 0.000621371192
#define METERS_CUTOFF   1000
#define FEET_CUTOFF     3281
#define FEET_IN_MILES   5280

@import MapKit;
@import CoreLocation;
@import CoreGraphics;

@interface GroupView() <MKMapViewDelegate, CLLocationManagerDelegate>
{
	NSMutableArray *chatrooms;
}

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) UINib *headerNib;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, assign) BOOL mapViewIsOpen;
@property (nonatomic, assign) CGRect mapViewFrame;
@property (nonatomic, assign) CGRect resultsTableViewFrame;
@property (nonatomic, weak) UIButton *searchHereButton;
@property (nonatomic, weak) UIButton *userLocationButton;
@property (nonatomic, weak) UIButton *refreshButton;
@property (nonatomic, weak) UIButton *filterButton;
@property (nonatomic, weak) UIView *filterView;
@property (nonatomic, weak) MKMapView *mapView;

@end

@implementation GroupView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.sections = chatrooms;
        self.headerNib = [UINib nibWithNibName:@"CSParallaxHeader" bundle:nil];
        [self.tabBarItem setImage:[UIImage imageNamed:@"tab_group"]];
        self.tabBarItem.title = @"POSTS";
    }
    return self;
}

//// From Old File
//- (void)viewDidLoad
//{
//	[super viewDidLoad];
//	self.title = @"Posts";
//    //	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(actionNew)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionPost)];
//	self.tableView.separatorInset = UIEdgeInsetsZero;
//	chatrooms = [[NSMutableArray alloc] init];
//}
//// End from old file


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    
    self.title = @"BAZR";
    chatrooms = [[NSMutableArray alloc] init];
    // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(actionNew)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionPost)];
    CSStickyHeaderFlowLayout *layout = (id)self.collectionViewLayout;
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
        layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
    }
    [self.collectionView registerNib:self.headerNib
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];
}

//- (IBAction)reloadButtonDidPress:(id)sender {
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.collectionView numberOfSections])];
//    //    NSIndexSet(indexesInRange: NSMakeRange(0, self.collectionView.numberOfSections()))
//    [self.collectionView reloadSections:indexSet];
//    
//}

//// From Old File
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    
	if ([PFUser currentUser] != nil)
	{
//		[self refreshTable];
//        [self.collectionView reloadSections:indexSet];
        [self refreshData];
	}
	else LoginUser(self);
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [chatrooms count];

//    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
//    return [chatrooms count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     //    NSDictionary *obj = self.sections[indexPath.section];
    PFObject *chatroom = chatrooms[indexPath.section];
    cell.textLabel.text = chatroom[PF_CHATROOMS_DESCRIPTION];
     //    cell.textLabel.text = [[obj allValues] firstObject];
     //    cell.detailTextLabel.text = chatroom[PF_CHATROOMS_DESCRIPTION];
     //	return cell;

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        NSDictionary *obj = self.sections[indexPath.section];
        CSCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:@"sectionHeader"
                                                                 forIndexPath:indexPath];
//        cell.textLabel.text = [[obj allKeys] firstObject];
        PFObject *chatroom = chatrooms[indexPath.section];
        cell.textLabel.text = chatroom[PF_CHATROOMS_NAME];
//        [cell.chatButton addTarget:self action:@selector(chatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"header"
                                                                                   forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

-(void)chatButtonPressed:(CSCell *)csCell {
    NSLog(@"Button Pressed");
}


#pragma mark - User actions
// From Old File
//- (void)actionNew
//{
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please enter a title for your post" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//	[alert show];
//}
//
- (void)actionPost
{
    UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"New Post" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert2.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [[alert2 textFieldAtIndex:1] setSecureTextEntry:NO];
    [[alert2 textFieldAtIndex:0] setPlaceholder:@"Title"];
    [[alert2 textFieldAtIndex:1] setPlaceholder:@"Description"];
    [alert2 show];
}


#pragma mark - UIAlertViewDelegate
// From Old File
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex != alertView.cancelButtonIndex)
	{
		UITextField *textField = [alertView textFieldAtIndex:0];
        UITextField *textField2 = [alertView textFieldAtIndex:1];
		if ([textField.text isEqualToString:@""] == NO)
		{
			PFObject *object = [PFObject objectWithClassName:PF_CHATROOMS_CLASS_NAME];
			object[PF_CHATROOMS_NAME] = textField.text;
            object[PF_CHATROOMS_DESCRIPTION] = textField2.text;
			[object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
			{
				if (error == nil)
				{
					[self refreshData];
				}
				else [ProgressHUD showError:@"Network error."];
			}];
		}
	}
}

// From Old File
- (void)refreshData
{
	[ProgressHUD show:nil];
	PFQuery *query = [PFQuery queryWithClassName:PF_CHATROOMS_CLASS_NAME];
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
	{
		if (error == nil)
		{
			[chatrooms removeAllObjects];
			for (PFObject *object in objects)
			{
				[chatrooms addObject:object];
			}
			[ProgressHUD dismiss];
			[self.collectionView reloadData];
		}
		else [ProgressHUD showError:@"Network error."];
	}];
}

#pragma mark - Table view data source
//// From Old File
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//	return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//	return [chatrooms count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//	if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//
//	PFObject *chatroom = chatrooms[indexPath.row];
//	cell.textLabel.text = chatroom[PF_CHATROOMS_NAME];
//    cell.detailTextLabel.text = chatroom[PF_CHATROOMS_DESCRIPTION];
//
//	return cell;
//}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    PFObject *chatroom = chatrooms[indexPath.section];
//    NSString *roomId = chatroom.objectId;
//    CreateMessageItem([PFUser currentUser], roomId, chatroom[PF_CHATROOMS_NAME]);
//    ChatView *chatView = [[ChatView alloc] initWith:roomId];
//    chatView.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:chatView animated:YES];
//}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    printf("This is a neat command!\n");
}

#pragma mark - Table view delegate
//// From Old File
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
//	PFObject *chatroom = chatrooms[indexPath.row];
//	NSString *roomId = chatroom.objectId;
//	CreateMessageItem([PFUser currentUser], roomId, chatroom[PF_CHATROOMS_NAME]);
//	ChatView *chatView = [[ChatView alloc] initWith:roomId];
//	chatView.hidesBottomBarWhenPushed = YES;
//	[self.navigationController pushViewController:chatView animated:YES];
//}

@end
