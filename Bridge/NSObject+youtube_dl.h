//
//  NSObject+youtube_dl.h
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/2/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <Python/Python.h>

#include <dlfcn.h>

@interface YouTube_dl: NSObject
- (void) run_server: (NSString*)url;
@end
