//
//  MyCustomView.h
//  HallOfFrames
//
//  Created by Andrew Bihl on 6/2/16.
//  Copyright © 2016 Andrew Bihl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCustomViewDelegate <NSObject>

-(void)updateColorValueWithRestorationID:(NSString*)color toFloat:(float)newValue;

@end


@interface MyCustomView : UIView
@property id<MyCustomViewDelegate> delegate;

@end
