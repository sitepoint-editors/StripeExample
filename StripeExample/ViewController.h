//
//  ViewController.h
//  StripeExample
//
//  Created by Ravi Pratap on 7/2/14.
//  Copyright (c) 2014 MobStac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPView.h"

@interface ViewController : UIViewController <STPViewDelegate>

@property (nonatomic, strong) STPView* stripeView;

@end
