//
//  CategoryView.m
//  bazr
//
//  Created by a on 3/3/15.
//  Copyright (c) 2015 KZ. All rights reserved.
//

#import "CategoryView.h"
#import "MFSideMenu.h"

#pragma mark - Macro definition

#define BUTTON_CORNER_RADIUS    5

#define CELL_ID             @"CategoryCell"
#define CATEGORY_COUNT      32

#define SELECTALL_COLOR     [UIColor redColor]

#define ACTIVE_TEXT_COLOR   [UIColor whiteColor]
#define DEACTIVE_TEXT_COLOR [UIColor lightGrayColor]
#define DEACTIVE_COLOR      [UIColor colorWithRed:109.f/256.f green:109.f/256.f blue:109.f/256.f alpha:1.f]


void changeButton(UIButton* button, BOOL state, UIColor *color)
{
    if (state)
    {
        [button setTitleColor:ACTIVE_TEXT_COLOR forState:UIControlStateNormal];
        button.backgroundColor = color;
    }
    else
    {
        [button setTitleColor:DEACTIVE_TEXT_COLOR forState:UIControlStateNormal];
        button.backgroundColor = DEACTIVE_COLOR;
    }
}

CategoryView *_shareInstence;

#pragma mark - CategoryCell

@interface CategoryCell()
{
    NSInteger catIndex;
    UIColor *selColor;
}
@property (weak, nonatomic) IBOutlet UIButton *btnCategory;

- (IBAction)pressCategory:(id)sender;

@end

@implementation CategoryCell

@synthesize delegate;

@synthesize btnCategory;

//- (void)awakeFromNib {
//    // Initialization code
//}
//

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];
    
    // Configure the view for the selected state
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void) setupUI : (NSInteger) index  color:(UIColor*)color
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSString *strCaption;
    
    catIndex = index;
    selColor = color;

    strCaption = [NSString stringWithFormat:@"Cat %ld", (long)catIndex + 1];
    [btnCategory setTitle:strCaption forState:UIControlStateNormal];
    
    changeButton(btnCategory, [delegate isSelected:index], selColor);
   
    btnCategory.layer.cornerRadius = BUTTON_CORNER_RADIUS;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (IBAction)pressCategory:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [delegate selectCateItem:catIndex];
    
    changeButton(btnCategory, [delegate isSelected:catIndex], selColor);
}


@end


#pragma mark - CategoryView

@interface CategoryView ()
{
    BOOL bSelectAll;
    NSMutableDictionary *categories;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UIView *hdrTable;
@property (strong, nonatomic) IBOutlet UIView *ftrTable;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectAll;

- (IBAction)onClose:(id)sender;
- (IBAction)onSelectAll:(id)sender;
@end

@implementation CategoryView

+(CategoryView*) shareInstance
{
    return _shareInstence;
}

@synthesize delegate;
@synthesize tableView, hdrTable, ftrTable;
//-------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidLoad];

    [[self menuContainerViewController].navigationController setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor blackColor];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor clearColor];

    _btnClose.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    _btnSelectAll.layer.cornerRadius = BUTTON_CORNER_RADIUS;
    
    _shareInstence = self;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    return CATEGORY_COUNT;
}

//-------------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    CategoryCell *cell = [tblView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    [cell setupUI:indexPath.row color:[UIColor blueColor]];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return hdrTable;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return ftrTable;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#if 0
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
#endif
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - CategoryCellDelegate
- (void) selectCateItem:(NSInteger)index
{
    NSString *strKey = [NSString stringWithFormat:@"Cat %ld", (long)index];
    NSString *strValue = [NSString stringWithFormat:@"Cat %ld", (long)index + 1];

    if (bSelectAll)
    {
        bSelectAll = NO;
        changeButton(_btnSelectAll, bSelectAll, SELECTALL_COLOR);
        
//        if ([categories objectForKey:strName])
        {
            [categories removeAllObjects];
            [categories setObject:strValue forKey:strKey];
        }
        
        [tableView reloadData];
        return;
    }
    
    if ([categories objectForKey:strKey])
    {
        [categories removeObjectForKey:strKey];
    }
    else
    {
        [categories setObject:strValue forKey:strKey];
    }
}

- (BOOL) isSelected:(NSInteger)index
{
    if (bSelectAll)
        return NO;
    
    NSString *strKey = [NSString stringWithFormat:@"Cat %ld", (long)index];

    return [categories objectForKey:strKey]?YES:NO;
}

#pragma mark - User Action Functions

- (void) showCategoryView : (NSMutableDictionary*)cates
{
    if (cates && [cates count] <= 0)
    {
        bSelectAll = YES;
    }
    else
    {
        bSelectAll = NO;
    }
    changeButton(_btnSelectAll, bSelectAll, SELECTALL_COLOR);
    if (!cates)
        cates = [[NSMutableDictionary alloc] init];

    categories = cates;
    
    [tableView reloadData];

    [self.menuContainerViewController setMenuState:MFSideMenuStateRightMenuOpen];
}


- (IBAction)onClose:(id)sender {
    if (bSelectAll)
        [categories removeAllObjects];
    
    else if ([categories count] <= 0)
    {
        [delegate onSelectCategory:nil];
        return;
    }
    [delegate onSelectCategory:categories];
}

- (IBAction)onSelectAll:(id)sender {
    bSelectAll = !bSelectAll;
    
    changeButton(_btnSelectAll, bSelectAll, SELECTALL_COLOR);

    [tableView reloadData];
}
@end
