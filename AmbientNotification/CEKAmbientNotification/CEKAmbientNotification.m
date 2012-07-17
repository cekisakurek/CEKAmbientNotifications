//
//  CEKAmbientNotification.m
//  AmbientNotification
//
//  Created by Cihan Emre Kisakurek on 7/16/12.
//  Copyright (c) 2012 ustat. All rights reserved.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CEKAmbientNotification.h"

@interface CEKAmbientNotification (){
    UIWindow *window;
    CEKNotificationItem *currentItem;
    NSMutableArray *notificationQue;
    BOOL showingNotification;
    BOOL hasNotification;
}
-(void)checkNotifications;
-(void)refresh;
-(void)_addItemToWindowAnimated:(BOOL)animated;
-(void)_removeItemFromWindowAnimated:(BOOL)animated;
@end


@implementation CEKAmbientNotification



+(CEKAmbientNotification*)manager{
    static CEKAmbientNotification *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CEKAmbientNotification alloc] init];
    });
    return sharedInstance;
}
-(id)init{
    self = [super init];
    if (self) {
        notificationQue=[[NSMutableArray alloc]init];
        window = [[[UIApplication sharedApplication].windows sortedArrayUsingComparator:^NSComparisonResult(UIWindow *win1, UIWindow *win2) {
            return win1.windowLevel - win2.windowLevel;
        }] lastObject];
        [window retain];
    }
    return self;
}


-(void)addNotificationItem:(CEKNotificationItem*)item{
    [notificationQue insertObject:item atIndex:0];
    [self checkNotifications];
    [self refresh];

    
}
-(void)removeNotificationItem:(CEKNotificationItem*)item{
    [notificationQue removeObject:item];
    [self checkNotifications];
    [self refresh];
    
}
-(void)checkNotifications{    
    hasNotification=[notificationQue count]>0?YES:NO;
}

-(void)refresh{
    
    if (showingNotification) {
        return;
    }
    
    else if ([notificationQue count]) {
        currentItem = [notificationQue lastObject];
        float callDelay=0;
        
        BOOL isStatusBarHidden=[[UIApplication sharedApplication]isStatusBarHidden];
        
        
        if (!isStatusBarHidden) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            callDelay=0.4;
            
        }
        showingNotification=YES;
        [NSTimer scheduledTimerWithTimeInterval:callDelay target:self selector:@selector(_addItemToWindowAnimated:) userInfo:nil repeats:NO];
        
    }
    else {
        [currentItem hideWithDirection:CEKNotificationItemHideDirectionDown];
        [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(_removeItemFromWindowAnimated:) userInfo:nil repeats:NO];

    }
    
 
}
-(void)_addItemToWindowAnimated:(BOOL)animated{

    [currentItem showInView:window animated:YES];
    [notificationQue removeObject:currentItem];
    showingNotification=NO;
    if (![notificationQue count]) {
        [currentItem setHideDirection:CEKNotificationItemHideDirectionDown];
    }
    [NSTimer scheduledTimerWithTimeInterval:currentItem.timeToLive target:self selector:@selector(next) userInfo:nil repeats:NO];
}
-(void)_removeItemFromWindowAnimated:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];

    
}
-(void)next{
    
    [currentItem hide];
    [self refresh];
}



@end
