//
//  ViewController.h
//  NeuroSample
//
//  Created by Roger Rush on 11/15/15.
//  Copyright © 2015 Roger Rush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGAccessoryDelegate.h"
#import "TGAccessoryManager.h"

@interface ViewController : UIViewController <TGAccessoryDelegate>

@property (weak, nonatomic) IBOutlet UIButton *baselineButton;
@property (weak, nonatomic) IBOutlet UIButton *taskButton;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property NSInteger count;
@property Boolean isSampling;

- (void)dataReceived:(NSDictionary *)data;
- (void)accessoryDidConnect:(EAAccessory *)accessory;
- (void)accessoryDidDisconnect;
- (void)setup;

- (IBAction)sampleBaseline:(UIButton *)sender;
- (IBAction)sampleTask:(UIButton *)sender;


@end

