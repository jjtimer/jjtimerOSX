//
//  JSRunner.m
//  jjtimerOSX
//
//  Created by Joey Gouly on 30/03/2014.
//  Copyright (c) 2014 jjtimer. All rights reserved.
//

#import "JSRunner.h"
#import "AppDelegate.h"

#import <JavaScriptCore/JavaScriptCore.h>

@protocol AppObjectExport <JSExport>
// Application namespace
-(void) set_title:(NSString*)str;
-(void) setResultText:(NSString*)str;
-(void) setTimerText:(NSString*)str;
// Util namespace
-(NSNumber *) getMilli;
JSExportAs(setInterval, -(void)setInterval:(JSValue *)fn timeInMs:(JSValue *)ms);
-(void) clearInterval:(JSValue *)intervalID;
@end

@interface AppObject : NSObject <AppObjectExport>
-(id) init:(AppDelegate *)app runner:(JSRunner *)js;
@end

@implementation AppObject
// private
{ AppDelegate *app;
  JSRunner *JS;
  NSTimer *interfaceTimer;
  JSValue *intervalFn; }

-(id) init:(AppDelegate *)app_ runner:(JSRunner *)js {
  self = [super init];
  app = app_;
  JS = js;
  return self;
}

-(void) set_title:(NSString*) str {
  [app.window setTitle:str];
}

-(void) setResultText:(NSString *)str {
  app.resultText.stringValue = str;
}

-(void) setTimerText:(NSString *)str {
  app.timerText.stringValue = str;
}

-(NSNumber *) getMilli {
  NSDate *d = [NSDate date];
  double x = [d timeIntervalSince1970];
  return [NSNumber numberWithDouble:x];
}

-(void) setInterval:(JSValue *)fn timeInMs:(JSValue *)ms {
  intervalFn = fn;
  interfaceTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                    target:self
                                                  selector:@selector(timerFired:)
                                                  userInfo:nil repeats:YES];
}

-(void) clearInterval:(JSValue *)intervalID {
  [interfaceTimer invalidate];
  interfaceTimer = nil;
}

-(void) timerFired:(NSTimer *)timer {
  [intervalFn callWithArguments:nil];
}

@end

@implementation JSRunner

JSContext* context;

-(id) init:(AppDelegate *)app {
  self = [super init];
  context = [[JSContext alloc] init];
  context[@"App"] = [[AppObject alloc] init:app runner:self];
  [context setExceptionHandler:^(JSContext *c, JSValue *err) {
    NSLog(@"%@", [err toString]);
  }];
  return self;
}

-(void) execute:(NSString *)str {
  assert(str != nil && "'str' cannot be nil!");
  [context evaluateScript:str];
}

@end
