

#import <UIKit/UIKit.h>
#import "CSCell.h"

@import CoreLocation;


@interface GroupView : UICollectionViewController <UIAlertViewDelegate>
@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, assign) BOOL includeUserLocation;

@end
