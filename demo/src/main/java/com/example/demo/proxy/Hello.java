package com.example.demo.proxy;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;


public class Hello {
	
	public Hello(){}
	
	public static void main(String[] a){
		
		 ByteArrayOutputStream code = new ByteArrayOutputStream();
		
		DataOutputStream out = new DataOutputStream(code);
		try {
			out.writeByte(123);
			out.writeByte(127);
			System.out.println(out.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
