/**
 * SDKSocialize
 *
 * Created by Your Name
 * Copyright (c) 2014 Your Company. All rights reserved.
 */

#import "ItScosftSdksocializeModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "TiBlob.h"

@implementation ItScosftSdksocializeModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"e2591cec-2166-41f6-9f08-80d59a788bde";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"it.scosft.sdksocialize";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

-(NSString*)getPathToModuleAsset:(NSString*) fileName
{
    // The module assets are copied to the application bundle into the folder pattern
    // "module/<moduleid>". One way to access these assets is to build a path from the
    // mainBundle of the application.
    
    NSString *pathComponent = [NSString stringWithFormat:@"modules/%@/%@", [self moduleId], fileName];
    NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
    
    return result;
}

-(NSString*)getPathToApplicationAsset:(NSString*) fileName
{
    // The application assets can be accessed by building a path from the mainBundle of the application.
    
    NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    return result;
}

-(TiBlob*)loadImageFromModule:(id)args
{
    ENSURE_SINGLE_ARG(args,NSString);
    
    NSLog(@"[ASSETSDEMO] loadImageFromModule %@", args);
    
    // Load the image from the module assets
    NSString *imagePath = [self getPathToModuleAsset:args];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (image == nil) {
        return nil;
    }
    
    // The image must be converted to a TiBlob before returning
    TiBlob *result = [[TiBlob alloc] initWithImage:image];
    
    NSLog(@"[ASSETSDEMO] %@", result);
    
    return result;
}

-(TiBlob*)loadImageFromApplication:(id)args
{
    ENSURE_SINGLE_ARG(args,NSString);
    
    NSLog(@"[ASSETSDEMO] loadImageFromApplication %@", args);
    
    // Load the image from the application assets
    NSString *imagePath = [self getPathToApplicationAsset:args];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (image == nil) {
        return nil;
    }
    
    // The image must be converted to a TiBlob before returning
    TiBlob *result = [[TiBlob alloc] initWithImage:image];
    
   // NSLog(@"[ASSETSDEMO] %@", result);
    
    return result;	
}


#pragma Public APIs

-(BOOL)init:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    [Socialize storeConsumerKey:[TiUtils stringValue:@"socializeKey" properties:args def:nil]];
    [Socialize storeConsumerSecret:[TiUtils stringValue:@"socializeSecret" properties:args def:nil]];
    [SZFacebookUtils setAppId:[TiUtils stringValue:@"facebokAppID" properties:args def:nil]];
    [SZPinterestUtils setApplicationId:[TiUtils stringValue:@"pinterestApp" properties:args def:nil]];
    [Socialize storeLocationSharingDisabled:[TiUtils boolValue:@"disableLocation" properties:args def:NO]];
    [SZWhatsAppUtils setShowInShare:YES];
    [SZTwitterUtils setConsumerKey:[TiUtils stringValue:@"twitterConsumerKey" properties:args def:nil] consumerSecret:[TiUtils stringValue:@"twitterConsumerSecret" properties:args def:nil] ];
    // NSLog(@"[INFO] FacebookID:%@, socializeKey:%@",[TiUtils stringValue:@"facebokAppID" properties:args def:nil],[TiUtils stringValue:@"socializeKey" properties:args def:nil]);
    
    
    // Specify a Socialize entity loader block
    [Socialize setEntityLoaderBlock:^(UINavigationController *navigationController, id<SocializeEntity>entity) {
        
        SampleEntityLoader *entityLoader = [[SampleEntityLoader alloc] initWithEntity:entity];
        
        if (navigationController == nil) {
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:entityLoader];
            [[[TiApp app] controller] presentViewController:navigationController animated:YES completion:nil];
        } else {
            [navigationController pushViewController:entityLoader animated:YES];
        }
    }];
    
    
      return YES;
    
    
}

-(id)createEntity:(id)args
{
    ENSURE_SINGLE_ARG(args, NSDictionary);
    NSString *image = [TiUtils stringValue:@"image" properties:args def:nil];
    NSString *description = [TiUtils stringValue:@"description" properties:args def:nil];
    NSString *url = [TiUtils stringValue:@"url" properties:args def:nil];
    NSString *name = [TiUtils stringValue:@"name" properties:args def:nil];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]  initWithObjectsAndKeys:nil];
    
    if(url == nil || name == nil){
        NSLog(@"[ERROR] Error Missing URL or NAME");
        return nil;
    }

    SZEntity *entity = [SZEntity entityWithKey:url
                                          name:name
                        ];
    
    if(image != nil){
        [params setObject:image forKey:@"szsd_thumb"];
    }
    
    if(description != nil)
    {
          [params setObject:image forKey:@"szsd_description"];
    }
    
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    NSAssert(error == nil, @"Error writing json: %@", [error localizedDescription]);
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    entity.meta = jsonString;
    
    
    [SZEntityUtils addEntity:entity success:^(id<SZEntity> serverEntity) {
       NSLog(@"[INFO] Entity Createa");
    } failure:^(NSError *error) {
        NSLog(@"[ERROR] Failure: %@", [error localizedDescription]);
    }];
    
    return  entity;
}

-(BOOL)handleOpenURL:(id)args
{
    ENSURE_SINGLE_ARG(args, NSString);
    return [Socialize handleOpenURL:[NSURL URLWithString:args]];
}

@end
