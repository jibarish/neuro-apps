//
//  ViewController.h
//  neuro
//
//  Created by Roger Rush on 11/21/15.
//  Copyright © 2015 Roger Rush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGAccessoryDelegate.h"
#import "TGAccessoryManager.h"
#import "NN.h"

@interface ViewController : UIViewController <TGAccessoryDelegate>

@property (strong, nonatomic) NN *nn;

- (void)dataReceived:(NSDictionary *)data;
- (void)accessoryDidConnect:(EAAccessory *)accessory;
- (void)accessoryDidDisconnect;


@end

