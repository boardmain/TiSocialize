/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2014 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ItScosftSdksocializeLikeView.h"

@implementation ItScosftSdksocializeLikeView
@synthesize likeButton = likeButton_;

-(void)initializeState
{
    [super initializeState];
    
    
    NSString *url = [self.proxy valueForUndefinedKey:@"url"];
    NSString *name =  [self.proxy valueForUndefinedKey:@"name"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]  initWithObjectsAndKeys:nil];

    self.entity = [SZEntity entityWithKey:url
                                     name:name
                   ];
    
    if([self.proxy valueForUndefinedKey:@"image"] != nil){
        [params setObject:[self.proxy valueForUndefinedKey:@"image"] forKey:@"szsd_thumb"];
    }
    
    if([self.proxy valueForUndefinedKey:@"description"] != nil)
    {
        [params setObject:[self.proxy valueForUndefinedKey:@"description"] forKey:@"szsd_description"];
    }else{
        [params setObject:name forKey:@"szsd_description"];
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSAssert(error == nil, @"Error writing json: %@", [error localizedDescription]);
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.entity.meta = jsonString;
    
    [SZEntityUtils addEntity:self.entity success:nil failure:nil];
    self.likeButton = [[SZLikeButton alloc] initWithFrame:CGRectNull entity: self.entity viewController:[[TiApp app] controller] tabBarStyle:YES];
    [self addSubview:self.likeButton];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    
    if (self.likeButton!=nil)
    {
        
        [TiUtils setView:self.likeButton positionRect:bounds];
        /*  [self.actionBar setFrame:frame];
         [self.actionBar setBounds:bounds];*/
    }
}

-(void)backgroundColor_:(id)color
{
    self.backgroundColor = [[TiUtils colorValue:color]_color];
}

- (void)changeLikeButtonEntity:(id)args {
    ENSURE_SINGLE_ARG(args, NSDictionary);
    SocializeEntity *newEntity = [SocializeEntity entityWithKey:[TiUtils stringValue:@"url" properties:args]
                                                           name:[TiUtils stringValue:@"name" properties:args]];
    self.likeButton.entity = newEntity;
}

@end
