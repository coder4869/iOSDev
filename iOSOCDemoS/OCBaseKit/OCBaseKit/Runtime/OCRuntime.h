/**
 *  OCRuntime.h
 *
 *  Created by coder4869 on 12/27/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import <objc/objc.h>
#import <objc/runtime.h>

void MethodExchange(SEL originalSEL, SEL swizzledSEL, Class aclass);




