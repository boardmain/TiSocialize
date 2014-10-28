/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ItScosftSdksocializeBarView.h"
/*#import "TiViewController.h"
#import "TiUIiOSNavWindowProxy.h"

UIViewController * ControllerForViewProxy(TiViewProxy * proxy);

UIViewController * ControllerForViewProxy(TiViewProxy * proxy)
{
    [[proxy view] setAutoresizingMask:UIViewAutoresizingNone];
    
    //make the proper resize !
    TiThreadPerformOnMainThread(^{
        [proxy windowWillOpen];
        [proxy reposition];
        [proxy windowDidOpen];
    },YES);
    return [[TiViewController alloc] initWithViewProxy:proxy];
}

UINavigationController * NavigationControllerForViewProxy(TiUIiOSNavWindowProxy *proxy)
{
    return [proxy controller];
}
*/

@interface ItScosftSdksocializeBarView(){
    float alpha;
    UIColor *bgColor;
}
@end

@implementation ItScosftSdksocializeBarView

-(void)initializeState{
    [super initializeState];
    
    
    alpha = 1;
    bgColor = [UIColor blackColor];
    
    NSString *image = [self.proxy valueForUndefinedKey:@"image"];
    NSString *description =  [self.proxy valueForUndefinedKey:@"description"];
    NSString *url = [self.proxy valueForUndefinedKey:@"url"];
    NSString *name =  [self.proxy valueForUndefinedKey:@"name"];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]  initWithObjectsAndKeys:nil];
    
    if([self.proxy valueForUndefinedKey:@"alpha"] != nil){
        alpha = [TiUtils floatValue:[self.proxy valueForKeyPath:@"alpha"]];
    }
    
    if([self.proxy valueForUndefinedKey:@"bgColor"] != nil){
        bgColor = [[TiUtils colorValue:[self.proxy valueForKeyPath:@"bgColor"]]_color];
    }
    
    if(url == nil || name == nil){
        NSLog(@"[ERROR] Error Missing URL or NAME");
        return nil;
    }
    
    self.entity = [SZEntity entityWithKey:url
                                     name:name
                    ];
    
    if(image != nil){
        [params setObject:image forKey:@"szsd_thumb"];
    }
    
    if(description != nil)
    {
        [params setObject:description forKey:@"szsd_description"];
    }else{
        [params setObject:name forKey:@"szsd_description"];
    }
    
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSAssert(error == nil, @"Error writing json: %@", [error localizedDescription]);
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.entity.meta = jsonString;
    

    
    [SZEntityUtils addEntity:self.entity success:^(id<SZEntity> serverEntity) {
        
        self.actionBar = [SZActionBar defaultActionBarWithFrame:CGRectZero entity:self.entity viewController:[[TiApp app] controller]];
        self.actionBar.backgroundColor = bgColor;
        self.actionBar.alpha = alpha;
        //[view addSubview:];
        [self addSubview:self.actionBar];
           } failure:^(NSError *error) {
        NSLog(@"[ERROR] Failure: %@", [error localizedDescription]);
    }];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
   
    if (self.actionBar!=nil)
    {

        [TiUtils setView:self.actionBar positionRect:bounds];
      /*  [self.actionBar setFrame:frame];
        [self.actionBar setBounds:bounds];*/
    }
}

@end
