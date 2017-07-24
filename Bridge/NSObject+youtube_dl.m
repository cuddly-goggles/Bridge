//
//  NSObject+youtube_dl.m
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/2/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

#import "NSObject+youtube_dl.h"

@implementation YouTube_dl: NSObject

int ret = 0;
unsigned int i;
NSString *tmp_path;
NSString *python_home;
NSString *python_path;
wchar_t *wpython_home;
const char* main_script;
wchar_t** python_argv;

int argc = 1;
char *argv[];

- (id)init {
    self = [super init];
    return self;
}
    
-(void) run_server:(NSString *)url {
    
    dispatch_queue_t myQueue = dispatch_queue_create("Fucking Queue",NULL);
    dispatch_async(myQueue, ^{
        NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
        
        // Special environment to prefer .pyo; also, don't write bytecode
        // because the process will not have write permissions on the device.
        putenv("PYTHONOPTIMIZE=1");
        putenv("PYTHONDONTWRITEBYTECODE=1");
        
        // Set the home for the Python interpreter
        python_home = [NSString stringWithFormat:@"%@/Library/Python.framework/Resources", resourcePath, nil];
        NSLog(@"PythonHome is: %@", python_home);
        wpython_home = Py_DecodeLocale([python_home UTF8String], NULL);
        Py_SetPythonHome(wpython_home);
        
        // Set the PYTHONPATH
        python_path = [NSString stringWithFormat:@"PYTHONPATH=%@/Library/Application Support/com.example.appname/app:%@/Library/Application Support/app_packages", resourcePath, resourcePath, nil];
        NSLog(@"PYTHONPATH is: %@", python_path);
        putenv((char *)[python_path UTF8String]);
        
        // iOS provides a specific directory for temp files.
        tmp_path = [NSString stringWithFormat:@"TMP=%@/tmp", resourcePath, nil];
        putenv((char *)[tmp_path UTF8String]);
        
        NSLog(@"Initializing Python runtime");
        Py_Initialize();
        
        // Set the name of the main script
        main_script = [
                       [[NSBundle mainBundle] pathForResource:@"__main__"
                                                       ofType:@"py"] cStringUsingEncoding:NSUTF8StringEncoding];
        
        if (main_script == NULL) {
            NSLog(@"Unable to locate appname main module file");
            exit(-1);
        }
        
        // Construct argv for the interpreter
        python_argv = PyMem_RawMalloc(sizeof(wchar_t*) * argc);
        
        python_argv[0] = Py_DecodeLocale(main_script, NULL);
        for (i = 1; i < argc; i++) {
            python_argv[i] = Py_DecodeLocale(argv[i], NULL);
        }
        
        PySys_SetArgv(argc, python_argv);
        
        // If other modules are using threads, we need to initialize them.
        PyEval_InitThreads();
        
        // Start the main.py script
        NSLog(@"Running %s", main_script);
        
        @try {
            FILE* fd = fopen(main_script, "r");
            if (fd == NULL) {
                ret = 1;
                NSLog(@"Unable to open main.py, abort.");
            } else {
                ret = PyRun_SimpleFileEx(fd, main_script, 1);
                NSLog(@"ruuuuuuuuuuuuuuuuuuuuuuuuning");
                if (ret != 0) {
                    NSLog(@"Application quit abnormally!");
                } else {
                }
            }
        }
        @catch (NSException *exception) {
            NSLog(@"Python runtime error: %@", [exception reason]);
        }
        @finally {
            Py_Finalize();
        }
        
        PyMem_RawFree(wpython_home);
        if (python_argv) {
            for (i = 0; i < argc; i++) {
                PyMem_RawFree(python_argv[i]);
            }
            PyMem_RawFree(python_argv);
        }
        NSLog(@"Leaving");
        
    });

}


@end

