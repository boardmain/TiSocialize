/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import <Socialize/Socialize.h>
#import "TiApp.h"
#import "TiUtils.h"

@interface ItScosftSdksocializeBarView : TiUIView <UIGestureRecognizerDelegate>{
}
@property (nonatomic, retain) SZActionBar *actionBar;
@property (nonatomic, retain) id<SZEntity> entity;
@end
