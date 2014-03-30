//
//  AppDelegate.m
//  jjtimerOSX
//
//  Created by Joey Gouly on 29/03/2014.
//  Copyright (c) 2014 jjtimer. All rights reserved.
//

#import "AppDelegate.h"

#import "JSRunner.h"

@implementation AppDelegate

JSRunner *JS;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    JS = [[JSRunner alloc] init:self];
}

@end
