//
//  MLRoomsViewController.h
//  Examples
//
//  Created by Cass Pangell on 7/28/14.
//  Copyright (c) 2014 com.estimote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeacon.h"


@interface MLRoomsViewController : UIViewController <ESTBeaconDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *beaconTable;
@property (nonatomic, strong) NSArray *beaconsArray;
@property (nonatomic) IBOutlet UILabel *selectLabel;

- (id)initWithBeacon:(ESTBeacon *)beacon;
@end
