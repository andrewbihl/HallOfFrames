//
//  MyCustomView.m
//  HallOfFrames
//
//  Created by Andrew Bihl on 6/2/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import "MyCustomView.h"

@implementation MyCustomView{
}



- (IBAction)onSliderMoved:(UISlider *)sender {
    NSLog(@"GO");
    float updatedValue = sender.value;
    NSString* sliderID = sender.restorationIdentifier;
    [self.delegate updateColorValueWithRestorationID:sliderID toFloat:updatedValue];
}

@end
