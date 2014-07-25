//
//  MLIdleViewController.h
//  Examples
//
//  Created by Cass Pangell on 7/22/14.
//  Copyright (c) 2014 com.estimote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeacon.h"

@interface MLIdleViewController : UIViewController{
    
    CGFloat redPoint, bluePoint, greenPoint;
}

@property (nonatomic) IBOutlet UIView *bgView;
@property (nonatomic) IBOutlet UILabel *distanceLabel;


- (id)initWithBeacon:(ESTBeacon *)beacon;

@end
