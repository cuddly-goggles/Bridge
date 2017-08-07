//
//  NSObject+youtube_dl.m
//  Bridge
//
//  Created by Sajjad Aboutalebi on 2/2/17.
//  Copyright © 2017 Rishe Co. All rights reserved.
//

#import "NSObject+ObjcFlask.h"

@implementation ObjcFlask: NSObject

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
PyObject* youtube_dl;

- (id) init
{
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    putenv("PYTHONOPTIMIZE=1");
    putenv("PYTHONDONTWRITEBYTECODE=1");
    python_home = [NSString stringWithFormat:@"%@/Library/Python.framework/Resources", resourcePath, nil];
    NSLog(@"PythonHome is: %@", python_home);
    wpython_home = Py_DecodeLocale([python_home UTF8String], NULL);
    Py_SetPythonHome(wpython_home);
    python_path = [NSString stringWithFormat:@"PYTHONPATH=%@/Library/Application Support/com.example.appname/app:%@/Library/Application Support/app_packages", resourcePath, resourcePath, nil];
    NSLog(@"PYTHONPATH is: %@", python_path);
    putenv((char *)[python_path UTF8String]);
    tmp_path = [NSString stringWithFormat:@"TMP=%@/tmp", resourcePath, nil];
    putenv((char *)[tmp_path UTF8String]);
    NSLog(@"Initializing Python runtime");
    Py_Initialize();
    python_argv = PyMem_RawMalloc(sizeof(wchar_t*) * argc);
    for (i = 1; i < argc; i++) {
        python_argv[i] = Py_DecodeLocale(argv[i], NULL);
    }
    
    PyEval_InitThreads();
    
    PyObject *sysModule = PyImport_ImportModule("sys");
    PyObject *sysModuleDict = PyModule_GetDict(sysModule);
    PyObject *pathObject = PyDict_GetItemString(sysModuleDict, "path");
    PyObject_CallMethod(pathObject, "insert", "(is)", 0, "../../");
    
    Py_DECREF(sysModule); // borrowed reference
    
    /* import and instantiate Cat */
    
    // from Cat import *
    PyObject *SimpleDL = PyImport_ImportModule("SimpleDL");
    
    // c = Cat()
    PyObject *YoutubeDL = PyDict_GetItemString(PyModule_GetDict(SimpleDL), "YoutubeDL");
    youtube_dl = PyObject_CallObject(YoutubeDL, NULL);
    
    Py_DECREF(SimpleDL);
    Py_DECREF(YoutubeDL);
    
    //PyObject_CallMethod(privateAPI,"scream",NULL);
    return self;
}

- (NSString*) excreact_info:(NSString *)url
{
    PyObject *name = PyObject_CallMethod(youtube_dl,"extract_info","(s)", url.UTF8String);
    assert(name != NULL);
    NSString* string = [NSString stringWithFormat:@"%s" , PyBytes_AsString(PyUnicode_AsUTF8String(name))];
    return string;

}

@end

