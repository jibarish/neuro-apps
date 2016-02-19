//
//  NN.m
//  neuro
//
//  Created by Roger Rush on 11/21/15.
//  Copyright © 2015 Roger Rush. All rights reserved.
//

#import "NN.h"

@implementation NN

- (void)test {
    // Use the designated initialiser to pass the network configuration and weights to the model.
    // Note: You do not need to specify the biased units (+1 above) in the configuration.
    
    NSArray *netConfig = @[@2, @1];
    double wts[] = {-30, 20, 20};
    NSData *weights = [NSData dataWithBytes:wts length:sizeof(wts)];
    
    MLPNeuralNet *model = [[MLPNeuralNet alloc] initWithLayerConfig:netConfig
                                                            weights:weights
                                                         outputMode:MLPClassification];
    // Predict output of the model for new sample
    double sample[] = {0, 1};
    NSData * vector = [NSData dataWithBytes:sample length:sizeof(sample)];
    NSMutableData * prediction = [NSMutableData dataWithLength:sizeof(double)];
    [model predictByFeatureVector:vector intoPredictionVector:prediction];
    
    double * assessment = (double *)prediction.bytes;
    NSLog(@"Model assessment is %f", assessment[0]);
}

- (void)setup {
    // Use the designated initialiser to pass the network configuration and weights to the model.
    // Note: You do not need to specify the biased units (+1 above) in the configuration.
    
    double b1 = 0.11084553;
    double b2 = -0.22241306;
    double b3 = -0.05005078;
    double b4 = -0.41555809;
    double w1 = -0.06051087;
    double w2 = -0.43323252;
    double w3 = -0.4068583;
    double w4 = -0.09226452;
    double w5 = -0.25619293;
    double w6 = 0.15275861;
    double w7 = -0.09631981;
    double w8 = -0.37837187;
    double w9 = -0.0736364;
    double w10 = -0.39365999;
    double w11 = -0.3267301;
    double w12 = 0.32696019;
    double w13 = 0.03124621;
    double w14 = 0.17466655;
    double w15 = -0.01558113;
    double w16 = 0.45328344;
    double w17 = 0.15411388;
    double w18 = 0.22335837;
    
    NSArray *netConfig = @[@5, @3, @1];
    double wts[] = {b1, b2, b3, b4, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18};
    NSData *weights = [NSData dataWithBytes:wts length:sizeof(wts)];
    
    MLPNeuralNet *model = [[MLPNeuralNet alloc] initWithLayerConfig:netConfig
                                                            weights:weights
                                                         outputMode:MLPClassification];
    model.hiddenActivationFunction = MLPSigmoid;
    model.outputActivationFunction = MLPSigmoid;
    
    NSArray *samples = @[@[@7044, @9689, @11807, @13458, @13174],
                         @[@113325, @102718, @2949, @29319, @14806],
                         @[@35062, @8872, @35916, @4802, @3347],
                         @[@28073, @19129, @26611, @8706, @4320],
                         @[@24741, @61846, @17209, @22731, @1864],
                         @[@36819, @38939, @31189, @10576, @2866],
                         @[@20276, @4472, @8770, @8556, @2929],
                         @[@23886, @12313, @11904, @7622, @2164],
                         @[@21252, @48296, @10066, @9073, @2621],
                         @[@13599, @6767, @39978, @8018, @2262],
                         @[@18348, @4631, @12277, @7528, @1478],
                         @[@24117, @7081, @33468, @9558, @3076],
                         @[@26797, @10960, @71748, @11986, @3297],
                         @[@11781, @39394, @49756, @12227, @2913],
                         @[@13644, @6043, @35697, @7286, @3417],
                         @[@12847, @8666, @34038, @4606, @2951],
                         @[@7067, @14694, @15921, @6652, @2328],
                         @[@44634, @10596, @27875, @10110, @4160],
                         @[@31098, @23126, @36295, @22391, @3553],
                         @[@9384, @20613, @25851, @4915, @3497]];
    
    int i = 0;
    for (i = 1; i < 20; i++) {
        // Predict output of the model for new sample
        double s1 = [samples[i][0] doubleValue];
        double s2 = [samples[i][1] doubleValue];
        double s3 = [samples[i][2] doubleValue];
        double s4 = [samples[i][3] doubleValue];
        double s5 = [samples[i][4] doubleValue];
        double sample[] = {s1, s2, s3, s4, s5};
        NSData * vector = [NSData dataWithBytes:sample length:sizeof(sample)];
        NSMutableData * prediction = [NSMutableData dataWithLength:sizeof(double)];
        [model predictByFeatureVector:vector intoPredictionVector:prediction];
        
        double * assessment = (double *)prediction.bytes;
        NSLog(@"Model assessment is %f", assessment[0]);
        
    }
}

@end
