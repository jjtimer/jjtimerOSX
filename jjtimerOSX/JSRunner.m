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
-(void) set_result_text:(NSString*)str;
// Util namespace
-(NSNumber *) getMilli;
JSExportAs(setInterval, -(void)setInterval:(JSValue *)fn timeInMs:(JSValue *)ms);
-(void) clearInterval:(JSValue *)intervalID;
@end

@interface AppObject : NSObject <AppObjectExport>
-(id) init:(AppDelegate *)app;

@end

@implementation AppObject
// private
{ AppDelegate *app; }

-(id) init:(AppDelegate *)app_ {
  self = [super init];
  app = app_;
  return self;
}

-(void) set_title:(NSString*) str {
  [app.window setTitle:str];
}

-(void) set_result_text:(NSString *)str {
  app.resultText.stringValue = str;
}

-(NSNumber *) getMilli {
  return @0;
}

-(void) setInterval:(JSValue *)fn timeInMs:(JSValue *)ms {

}

-(void) clearInterval:(JSValue *)intervalID {

}

@end

@implementation JSRunner

JSContext* context;

-(id) init:(AppDelegate *)app {
  self = [super init];
  context = [[JSContext alloc] init];
  context[@"App"] = [[AppObject alloc] init:app];
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
