package com.example.demo.proxy;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class ProxyHandler implements InvocationHandler {
	
	private RealFunction real;
	
	public ProxyHandler( RealFunction real){
		this.real=real;
	}
	

	@Override
	public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
		System.out.println("I'm staring");
		if(method.getName().equals("sayHi")){
			System.out.println("hahah");
			return 1;
		}
		Object result= method.invoke(real,args);
		System.out.println("invoking result:"+result);
		return result;
	}

}
