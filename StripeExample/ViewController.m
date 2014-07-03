//
//  ViewController.m
//  StripeExample
//
//  Created by Ravi Pratap on 7/2/14.
//  Copyright (c) 2014 MobStac. All rights reserved.
//

#import "ViewController.h"

#define STRIPE_PUBLISHABLE_KEY @"YOUR_PUBLISHABLE_KEY_HERE"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stripeView = [[STPView alloc] initWithFrame:CGRectMake(15,80,290,55)
                                              andKey:STRIPE_PUBLISHABLE_KEY];
    self.stripeView.delegate = self;
    [self.view addSubview:self.stripeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)savePressed:(id)sender
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    // Call 'createToken' when the user hits “Submit”
    [self.stripeView createToken:^(STPToken *token, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            // Handle error
            NSLog(@"Error %@",error);
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Credit Card check failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            // Ok, step 5.
            [self hasToken:token];
        }
    }];
}


- (void)hasToken:(STPToken *)token
{
    NSLog(@"Received token %@", token.tokenId);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://example.com"]];
    request.HTTPMethod = @"POST";
    NSString *body     = [NSString stringWithFormat:@"stripeToken=%@", token.tokenId];
    request.HTTPBody   = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               [[[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your card was charged successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                           }];
}


@end
