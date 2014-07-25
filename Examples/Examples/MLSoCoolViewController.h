//
//  MLSoCoolViewController.h
//  Examples
//
//  Created by Cass Pangell on 7/22/14.
//  Copyright (c) 2014 com.estimote. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESTBeacon.h"
#import "MLDrawing.h"

@interface MLSoCoolViewController : UIViewController {
    NSString* proximityString;
    MLDrawing *drawing;
    double mdiameter;
    double lWidth;
}

- (id)initWithBeacon:(ESTBeacon *)beacon;
-(void)setDiameter:(double)dmeter;
-(double)getDiameter;
-(void)setLineWidth:(double)lW;
-(double)getLineWidth;
@end
