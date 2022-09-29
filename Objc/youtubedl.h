//
//  youtubedl.h
//  Bridge
//
//  Created by Sajjad Aboutalebi on 3/7/18.
//  Copyright © 2018 Sajjad Aboutalebi. All rights reserved.
//

#include "Python.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include <dlfcn.h>

@interface youtubedl : NSObject
    - (void) run_server: (int)port;
@end
