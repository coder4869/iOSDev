/**
 *  OCRuntime.m
 *
 *  Created by coder4869 on 12/27/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import "OCRuntime.h"

void MethodExchange(SEL originalSEL, SEL swizzledSEL, Class aclass) {
    Method originalMethod = class_getInstanceMethod(aclass, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(aclass, swizzledSEL);
    BOOL didAddMethod = class_addMethod(aclass,
                                        originalSEL,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(aclass,
                            swizzledSEL,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
