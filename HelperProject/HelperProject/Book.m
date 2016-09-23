//
//  Book.m
//  HelperProject
//
//  Created by hushijun on 15/9/1.
//  Copyright (c) 2015年 hushijun. All rights reserved.
//

#import "Book.h"

@implementation Book
@dynamic name;// 不能写成name = _name;否则编译器马上报错
@dynamic author;
@synthesize version = _version;


//若对于一个属性使用了@dynamic var = _var，则编译器立马报错。这样你就无法像@synthesize那样在var的setter方法和getter方法中使用_var，当然你更不能编写如下的setter方法和getter方法
//@dynamic var = _var;




- (id)init
{
    self = [super init];
    if(self){
         _propertiesDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//----------------------------------------------------------------------------
//协议中的方法实现
- (void) btnCanceled:(NSString *) str;
{
    
}

//协议中的属性，实现该协议的对象必须实现对应的get、set方法
-(void) setStrTest:(NSString *) str
{
    //    _strTest=str;//由于类目不能声明实例变量，所以这里没法实现对属性的成员变量赋值
    NSLog(@"类目中伪属性strTest的set方法。。。");
}
//协议中的属性，实现该协议的对象必须实现对应的get、set方法
-(NSString *) strTest
{
    NSString *str=@"test字符串";
    NSLog(@"类目中伪属性strTest的get方法。。。");
    return str;
}
//----------------------------------------------------------------------------


//- (NSString *)name
//{
//    if(nil == _name)
//    {
//        _name = @"you forgot inputbook name";
//    }
//    
//    return _name;
//}
//
//- (void)setName:(NSString *)name
//{
//    _name = name;
//    NSLog(@"_name address:%p", _name);
//}
//
//
//
//- (NSString *)author
//{
//    if(nil == _author)
//    {
//        _author = @"you forgot inputbook author";
//  
//    }
//    return _author;
//}
//
//
//
//- (void)setAuthor:(NSString *)author
//{
//    _author = author;
//}


//从上面的代码可以看出，
//用@dynamic后，可以在存取方法中访问一个私有变量来赋值或取值。
//而@synthesize则直接用@synthesize var = _var；来让属性和私有变量直接等同起来。
//这就是二者在书写形式上的差别。



//通过消息转发来实现@dynamic的存取方法:使用此方法，请注销掉上面的getset方法
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSLog(@"1--methodSignatureForSelector");
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0)
    {
        NSLog(@"1--set");
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }else{
        NSLog(@"1--get");
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSLog(@"2--forwardInvocation");
    NSString *key = NSStringFromSelector([invocation selector]);
    if ([key rangeOfString:@"set"].location == 0)
    {
        NSLog(@"2--set");
        key= [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        NSString *obj;
        [invocation getArgument:&obj atIndex:2];
        [_propertiesDict setObject:obj forKey:key];
        
    }else{
        NSLog(@"2--get");
        NSString *obj = [_propertiesDict objectForKey:key];
        [invocation setReturnValue:&obj];
    }
}



@end
