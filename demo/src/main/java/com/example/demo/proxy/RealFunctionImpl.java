package com.example.demo.proxy;

public class RealFunctionImpl implements RealFunction {

	@Override
	public void sayHi(String name) {
		System.out.println(name);

	}

	@Override
	public void sayYeah(String name) {
		System.out.println("yeah");
		
	}

}
