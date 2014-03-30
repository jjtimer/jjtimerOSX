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

NSString *loadFile(NSString *path) {
  NSError *error = nil;
  NSString *fileRoot = [[NSBundle mainBundle] pathForResource:path ofType:@"js"];
  NSString *contents = [NSString stringWithContentsOfFile:fileRoot encoding:NSUTF8StringEncoding error:&error];
  assert(error == nil);
  return contents;
}

static NSString *initJS = @"";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  JS = [[JSRunner alloc] init:self];
  [JS execute:loadFile(@"jjtimer-core/src/event")];
  [JS execute:loadFile(@"jjtimer-core/src/timer")];
  [JS execute:loadFile(@"jjtimer-core/src/session")];
  [JS execute:initJS];
}

@end
