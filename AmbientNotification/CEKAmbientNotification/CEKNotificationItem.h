//
//  CEKNotificationItem.h
//  AmbientNotification
//
//  Created by Cihan Emre Kisakurek on 7/16/12.
//  Copyright (c) 2012 ustat(http://www.cekisakurek.com/. All rights reserved.
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






#import <Foundation/Foundation.h>

enum CEKNotificationHideDirection {
    CEKNotificationItemHideDirectionUp = -1,
    CEKNotificationItemHideDirectionDown = 1
    };
typedef NSInteger CEKNotificationHideDirection;


@interface CEKNotificationItem : UIView

//notification hide direction. default is CEKNotificationItemHideDirectionUp
@property(nonatomic,assign)CEKNotificationHideDirection hideDirection;
//notification life time
@property(nonatomic,assign)float timeToLive;
//notification Id
@property(nonatomic,assign)int Id;


+(CEKNotificationItem*)notificationWithMessage:(NSString*)message;
+(CEKNotificationItem*)notificationWithImage:(UIImage*)image;
+(CEKNotificationItem*)notificationWithCustomView:(UIView*)view;

+(CEKNotificationItem*)notificationWithMessage:(NSString*)message timeToLive:(float)timeToLive;
+(CEKNotificationItem*)notificationWithCustomView:(UIView*)view timeToLive:(float)timeToLive;
+(CEKNotificationItem*)notificationWithImage:(UIImage*)image timeToLive:(float)_timeToLive;



-(id)initWithView:(UIView*)view timeToLive:(float)_timeToLive;

-(void)showInView:(UIView*)view animated:(BOOL)animated;
-(void)hide;
-(void)hideWithDirection:(CEKNotificationHideDirection)directon;
@end
