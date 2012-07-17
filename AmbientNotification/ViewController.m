//
//  ViewController.m
//  AmbientNotification
//
//  Created by Cihan Emre Kisakurek on 7/16/12.
//  Copyright (c) 2012 ustat. All rights reserved.
//

#import "ViewController.h"
#import "CEKAmbientNotification.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CEKNotificationItem *item=[CEKNotificationItem notificationWithMessage:@"message1" timeToLive:2];
    CEKNotificationItem *item2=[CEKNotificationItem notificationWithMessage:@"message 2"];
    
    [[CEKAmbientNotification manager]addNotificationItem:item];
    [[CEKAmbientNotification manager]addNotificationItem:item2];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(remove:) userInfo:item2 repeats:NO];
}
-(void)remove:(CEKNotificationItem*)item{
    [[CEKAmbientNotification manager]removeNotificationItem:item];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(next:) userInfo:nil repeats:NO];
}
-(void)next:(id)sender{
    CEKNotificationItem *item=[CEKNotificationItem notificationWithMessage:@"message 3" timeToLive:2];
    [[CEKAmbientNotification manager]addNotificationItem:item];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
