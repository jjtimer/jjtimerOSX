//
//  JSRunner.h
//  jjtimerOSX
//
//  Created by Joey Gouly on 30/03/2014.
//  Copyright (c) 2014 jjtimer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;

@interface JSRunner : NSObject

-(id) init:(AppDelegate *)app;

-(void) execute:(NSString *)str;

@end
