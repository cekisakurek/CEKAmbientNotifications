//
//  CEKNotificationItem.m
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

#import "CEKNotificationItem.h"
#define FRAME CGRectMake(0, 0, 320, 20)
@implementation CEKNotificationItem
@synthesize timeToLive,Id;
@synthesize hideDirection;


+(CEKNotificationItem*)notificationWithMessage:(NSString*)message{
    return [CEKNotificationItem notificationWithMessage:message timeToLive:INFINITY];
}

+(CEKNotificationItem*)notificationWithMessage:(NSString*)message timeToLive:(float)_timeToLive{
    
    UILabel *label=[[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [label setTextAlignment:UITextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:message];
    
    CEKNotificationItem *item=[[CEKNotificationItem alloc]initWithView:label timeToLive:_timeToLive];
    return [item autorelease];    
}
+(CEKNotificationItem*)notificationWithImage:(UIImage*)image {
    return [CEKNotificationItem notificationWithImage:image timeToLive:INFINITY];
}
+(CEKNotificationItem*)notificationWithImage:(UIImage*)image timeToLive:(float)_timeToLive{
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    CEKNotificationItem *item=[[CEKNotificationItem alloc]initWithView:imageView timeToLive:_timeToLive];
    [imageView release];
    return [item autorelease]; 
}
+(CEKNotificationItem*)notificationWithCustomView:(UIView*)view {
    return [CEKNotificationItem notificationWithCustomView:view timeToLive:INFINITY];
}
+(CEKNotificationItem*)notificationWithCustomView:(UIView*)view timeToLive:(float)_timeToLive{
    CEKNotificationItem *item=[[CEKNotificationItem alloc]initWithView:view timeToLive:_timeToLive];
    return [item autorelease];    
}


-(id)initWithView:(UIView*)view timeToLive:(float)_timeToLive{
    CGRect frame=FRAME;
    frame.origin.y=+frame.size.height;
    self =[super initWithFrame:frame];
    if (self) {
        [self setClipsToBounds:YES];
        [self setHideDirection:CEKNotificationItemHideDirectionUp];
        [self setTimeToLive:_timeToLive];
        [view setFrame:self.bounds];
        [self addSubview:view];
    }
    return self;
}


-(void)showInView:(UIView*)view animated:(BOOL)animated{
    
    [view addSubview:self];
    if (animated) {
        
        [UIView animateWithDuration:0.25 animations:^(){
            [self setFrame:FRAME];
            
        } completion:^(BOOL finihed){
        }];        
    }
    else {
        [self setFrame:FRAME];
    }
    [view sendSubviewToBack:self];
}
-(void)hide{
    [self hideWithDirection:hideDirection];
}
-(void)hideWithDirection:(CEKNotificationHideDirection)directon{
    [UIView animateWithDuration:0.3 animations:^(){
        CGRect frame=FRAME;
        frame.origin.y=directon*frame.size.height;
        [self setFrame:frame];
    
    } completion:^(BOOL finished){
        //there is a glitch this is for the fix 
        //[self removeFromSuperview];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
    }];
}



@end
