//
//  ViewController.m
//  NeuroSample
//
//  Created by Roger Rush on 11/15/15.
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
    [self setup];
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
    if (_count < 20 && !_isSampling) {
        if ([[data valueForKey:@"poorSignal"] intValue] == 0)
            _statusLabel.text = @"Ready!";
        else
            _statusLabel.text = @"Poor Signal!";
    } else if (_count < 20) {
        NSInteger eegDelta = [[data valueForKey:@"eegDelta"] intValue];
        NSInteger eegTheta = [[data valueForKey:@"eegTheta"] intValue];
        NSInteger eegLowAlpha = [[data valueForKey:@"eegLowAlpha"] intValue];
        NSInteger eegHighAlpha = [[data valueForKey:@"eegHighAlpha"] intValue];
        NSInteger eegLowBeta = [[data valueForKey:@"eegLowBeta"] intValue];
        NSInteger eegHighBeta = [[data valueForKey:@"eegHighBeta"] intValue];
        NSInteger eegLowGamma = [[data valueForKey:@"eegLowGamma"] intValue];
        NSInteger eegHighGamma = [[data valueForKey:@"eegHighGamma"] intValue];
        
        // Sometimes we get null values
        if (eegDelta == 0) return;
        
        NSInteger eegAlphaAvg = (eegHighAlpha + eegLowAlpha) / 2;
        NSInteger eegBetaAvg = (eegHighBeta + eegLowBeta) / 2;
        NSInteger eegGammaAvg = (eegHighGamma + eegLowGamma) / 2;
        
        NSLog(@"%ld:%ld:%ld:%ld:%ld:", (long)eegDelta, (long)eegTheta, (long)eegAlphaAvg, (long)eegBetaAvg, (long)eegGammaAvg);
        _count++;
        _countLabel.text = [NSString stringWithFormat:@"%d", _count];
    } else {
        [self setup];
    }
}

- (void)accessoryDidConnect:(EAAccessory *)accessory {
    [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    NSLog(@"%@ was connected to this device.", [accessory name]);
}

- (void)accessoryDidDisconnect {
    NSLog(@"An accessory was disconnected.");
}

- (void)setup {
    // Blue
    _baselineButton.backgroundColor = [UIColor colorWithRed:0.000 green:0.486 blue:0.969 alpha:1.00];
    _taskButton.backgroundColor = [UIColor colorWithRed:0.000 green:0.486 blue:0.969 alpha:1.00];
    _statusLabel.text = @"";
    _countLabel.text = @"";
    _count = 0;
    _isSampling = false;
}

- (IBAction)sampleBaseline:(UIButton *)sender {
    NSLog(@"Baseline");
    [self setup];
    _baselineButton.backgroundColor = [UIColor colorWithRed:0.969 green:0.251 blue:0.216 alpha:1.00];
    _statusLabel.text = @"Sampling...";
    _isSampling = true;
}

- (IBAction)sampleTask:(UIButton *)sender {
    NSLog(@"Task");
    [self setup];
    _taskButton.backgroundColor = [UIColor colorWithRed:0.969 green:0.251 blue:0.216 alpha:1.00];
    _statusLabel.text = @"Sampling...";
    _isSampling = true;
}

@end
