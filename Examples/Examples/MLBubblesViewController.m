//
//  MLSoCoolViewController.m
//  Examples
//
//  Created by Cass Pangell on 7/22/14.
//  Copyright (c) 2014 com.estimote. All rights reserved.
//

#import "MLBubblesViewController.h"
#import "ESTBeaconManager.h"
#import <AudioToolbox/AudioServices.h>
#import "MLDrawing.h"

@interface MLBubblesViewController () <ESTBeaconManagerDelegate>{
    
}

@property (nonatomic, strong) ESTBeacon         *beacon;
@property (nonatomic, strong) ESTBeaconManager  *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion   *beaconRegion;

@end

@implementation MLBubblesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithBeacon:(ESTBeacon *)beacon
{
    self = [super init];
    if (self)
    {
        self.beacon = beacon;
        NSLog(@"BEACON %@", beacon.macAddress);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    /*
     * BeaconManager setup.
     */
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    self.beaconRegion = [[ESTBeaconRegion alloc] initWithProximityUUID:self.beacon.proximityUUID
                                                                 major:[self.beacon.major unsignedIntValue]
                                                                 minor:[self.beacon.minor unsignedIntValue]
                                                            identifier:@"RegionIdentifier"];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegion];
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    if (beacons.count > 0)
    {
        ESTBeacon *firstBeacon = [beacons firstObject];
        
        // [self textForProximity:firstBeacon.proximity];
       // [self createSomethingCool:[self textForProximity:firstBeacon.proximity]];
        [self createSomethingBetter:firstBeacon.distance];
        
    }
}

-(void)createSomethingCool:(NSString*)proximity {
    double duration;
    
    if ([proximity isEqualToString:@"Far"]) {
        lWidth = 3.0;
        duration = 1.5;
    }else if ([proximity isEqualToString:@"Near"]){
        lWidth = 5.0;
        duration = 1.0;
    }else if ([proximity isEqualToString:@"Immediate"]){
        lWidth = 15.0;
        duration = 0.5;
    }else{ //unknown
        lWidth = 1.0;
    }
    
    drawing = [[MLDrawing alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(mdiameter/2), (self.view.frame.size.height/2)-(mdiameter/2), mdiameter, mdiameter) andDiameter:mdiameter andLineWidth:lWidth];
    
    [self.view addSubview:drawing];
    
    drawing.alpha = 1;
    [UIView animateWithDuration:duration animations:^(void) {
        drawing.alpha = 0;
        drawing.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished){
        //[drawing removeFromSuperview];
    }];
    
    
}

-(void)createSomethingBetter:(NSNumber*)distance{
        NSLog(@"DISTANCE*100 %f", [distance doubleValue]*100);
    double dist = [distance doubleValue];
    [self setDiameter:70.0];
    lWidth = 10.0;
    
    drawing = [[MLDrawing alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-(mdiameter/2), (self.view.frame.size.height/2)-(mdiameter/2), mdiameter, mdiameter) andDiameter:mdiameter andLineWidth:lWidth];
    
    [self.view addSubview:drawing];
    
    drawing.alpha = 1;
    [UIView animateWithDuration:dist*70 animations:^(void) {
        drawing.alpha = 0;
        drawing.transform = CGAffineTransformMakeScale(5, 5);
    } completion:^(BOOL finished){
        //[drawing removeFromSuperview];
    }];
}

-(void)setDiameter:(double)dmeter{
    mdiameter = dmeter;
}

-(double)getDiameter{
    return mdiameter;
}

#pragma mark -

- (NSString *)textForProximity:(CLProximity)proximity
{

    
    switch (proximity) {
        case CLProximityFar:
            
            //  [self performSelector:@selector(vibrate) withObject:self afterDelay:5.0f];
            [self setDiameter:100.0];
            NSLog(@"Far");
            return @"Far";
            break;
        case CLProximityNear:
            
            // [self performSelector:@selector(vibrate) withObject:self afterDelay:2.0f];
            [self setDiameter:200.0];//200
            NSLog(@"Near");
            return @"Near";
            break;
        case CLProximityImmediate:
            
            // [self performSelector:@selector(vibrate) withObject:self afterDelay:.3f];
            [self setDiameter:250.0];//250
            NSLog(@"Immediate");
            return @"Immediate";
            break;
            
        default:
            [self setDiameter:20.0];
            NSLog(@"unknown");
            return @"Unknown";
            break;
    }
}

-(void)vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
