//
//  ViewController.m
//  neuro
//
//  Created by Roger Rush on 11/21/15.
//  Copyright © 2015 Roger Rush. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if([[TGAccessoryManager sharedTGAccessoryManager] accessory] != nil) {
        [[TGAccessoryManager sharedTGAccessoryManager] stopStream];
        [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    }
    _nn = [[NN alloc] init];
    [_nn setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
if([[TGAccessoryManager sharedTGAccessoryManager] connected])
    [[TGAccessoryManager sharedTGAccessoryManager] stopStream];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[TGAccessoryManager sharedTGAccessoryManager] teardownManager];
}

- (void)dataReceived:(NSDictionary *)data {
    NSInteger eegDelta = [[data valueForKey:@"eegDelta"] intValue];
    NSInteger eegTheta = [[data valueForKey:@"eegTheta"] intValue];
    NSInteger eegLowAlpha = [[data valueForKey:@"eegLowAlpha"] intValue];
    NSInteger eegHighAlpha = [[data valueForKey:@"eegHighAlpha"] intValue];
    NSInteger eegLowBeta = [[data valueForKey:@"eegLowBeta"] intValue];
    NSInteger eegHighBeta = [[data valueForKey:@"eegHighBeta"] intValue];
    NSInteger eegLowGamma = [[data valueForKey:@"eegLowGamma"] intValue];
    NSInteger eegHighGamma = [[data valueForKey:@"eegHighGamma"] intValue];
    
    if (eegDelta == 0) return;
    
    NSInteger eegAlphaAvg = (eegHighAlpha + eegLowAlpha) / 2;
    NSInteger eegBetaAvg = (eegHighBeta + eegLowBeta) / 2;
    NSInteger eegGammaAvg = (eegHighGamma + eegLowGamma) / 2;
    
    NSLog(@"Delta: %ld", (long)eegDelta);
    NSLog(@"Theta: %ld", (long)eegTheta);
    NSLog(@"Alpha Avg: %ld", (long)eegAlphaAvg);
    NSLog(@"Beta Avg: %ld", (long)eegBetaAvg);
    NSLog(@"Gamma Avg: %ld", (long)eegGammaAvg);
}


- (void)accessoryDidConnect:(EAAccessory *)accessory {
    [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    NSLog(@"%@ was connected to this device.", [accessory name]);
}

- (void)accessoryDidDisconnect {
    NSLog(@"An accessory was disconnected.");
}

@end
