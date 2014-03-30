//
//  JSRunner.m
//  jjtimerOSX
//
//  Created by Joey Gouly on 30/03/2014.
//  Copyright (c) 2014 jjtimer. All rights reserved.
//

#import "JSRunner.h"

#import <JavaScriptCore/JavaScriptCore.h>

@implementation JSRunner

JSContext* context;

-(id) init:(AppDelegate *)app {
  self = [super init];
  context = [[JSContext alloc] init];
  return self;
}

-(void) execute:(NSString *)str {
  assert(str != nil && "'str' cannot be nil!");
  [context evaluateScript:str];
}

@end
