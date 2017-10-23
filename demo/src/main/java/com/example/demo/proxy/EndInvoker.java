package com.example.demo.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

public class EndInvoker {
	
	public static void main(String[] a){
		RealFunction realFunc=new RealFunctionImpl();
		InvocationHandler proxy=new ProxyHandler(realFunc);
		ClassLoader realFuncCL= realFunc.getClass().getClassLoader();
		
		RealFunction rf1=(RealFunction) Proxy.newProxyInstance(realFuncCL, realFunc.getClass().getInterfaces(), proxy);
		rf1.sayHi("123");
		
		rf1.sayYeah("123");
		
	}

}
