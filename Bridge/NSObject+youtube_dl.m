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
wchar_t *wpython_home;
const char* main_script;
wchar_t** python_argv;
NSString * resourcePath;
PyObject *result;

- (id)init {
    self = [super init];
    return self;
}
    
-(void) exctract:(NSString *)url completion:(void(^)(NSString* done))completionBlock {
    
    dispatch_queue_t myQueue = dispatch_queue_create("Fucking Queue",NULL);
    dispatch_async(myQueue, ^{
        resourcePath = [[NSBundle mainBundle] resourcePath];
        // Special environment to prefer .pyo; also, don't write bytecode
        // because the process will not have write permissions on the device.
        putenv("PYTHONOPTIMIZE=1");
        putenv("PYTHONDONTWRITEBYTECODE=1");
        python_home = [NSString stringWithFormat:@"%@/Library/Python.framework/Resources", resourcePath, nil];
        NSLog(@"PythonHome is: %@", python_home);
        wpython_home = Py_DecodeLocale([python_home UTF8String], NULL);
        Py_SetPythonHome(wpython_home);
        // iOS provides a specific directory for temp files.
        tmp_path = [NSString stringWithFormat:@"TMP=%@/tmp", resourcePath, nil];
        putenv((char *)[tmp_path UTF8String]);
        NSLog(@"Initializing Python runtime");
        
        Py_Initialize();
        
        NSLog(@"\(%d)", Py_IsInitialized());
        
        PyObject* sys = PyImport_ImportModule( "sys" );
        PyObject* sys_path = PyObject_GetAttrString( sys, "path");
        PyObject* folder_path = PyUnicode_FromString(resourcePath.UTF8String);
        PyList_Append( sys_path, folder_path );
        PyObject *module = PyImport_ImportModule("main");
        assert(module != NULL);
        PyObject* klass = PyObject_GetAttrString(module, "YoutubeDL");
        assert(klass != NULL);
        PyObject* instance = PyObject_CallObject(klass, NULL);
        assert(instance != NULL);
        NSLog(@"%d", PyEval_ThreadsInitialized());
        PyEval_InitThreads();
        @try {
            result = PyObject_CallMethod(instance, "extractInfo", "(s)", url.UTF8String);
        } @catch (NSException *exception) {
            if(PyErr_Occurred()) {
                NSLog(@"err");
            }
        } @finally {
            NSLog(@"finally");
        }
        
        Py_Finalize();
        completionBlock([[NSString alloc] initWithCString: PyUnicode_AsUTF8(result) encoding:NSUTF8StringEncoding]);
    });

}


@end

