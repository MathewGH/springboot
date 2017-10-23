package com.example.demo.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Be aware of the difference btw a RESTFul request and a normal request.
 * @author ganpeng1
 *
 */
@Controller
public class WebController {

	@RequestMapping("/showEditPage")
	public String showEdit(Map<String, Object> model, Locale locale) {
		System.out.println(locale.toString());
		model.put("time", new Date());
		model.put("message", "yello");
		return "/pages/program/editprogram";
	}

	@RequestMapping(value="/logoutSuccess")
	public String logout() {

		return "logout";
	}
	
	@PostMapping("/loginSuccess")
	public ModelAndView login(@RequestParam String username,@RequestParam String password){
		Map<String,Object> model=new HashMap<String,Object>();
		model.put("username", username);
		return new ModelAndView("/pages/program/loginsuccess",model);
	}

	@RequestMapping("/123")
	public ModelAndView threwException(Map<String, Object> model) throws Exception {
		
		throw new Exception("error detail...");
	}
	
	@RequestMapping("/home")
	public String toIndex(Map<String, Object> model)  {
		return "/pages/index";
	}
	
	@RequestMapping("/loginFailed")
	public ModelAndView loginFailed(Map<String, Object> model)  {
		Map<String,Object> model1=new HashMap<String,Object>();
		String msg="username or pwd is incorrect";
		model1.put("errorMsg", msg);
		return new ModelAndView("/pages/program/errorpage", model1);
	}

	@ExceptionHandler({Exception.class})
	public ModelAndView exception(Exception e) {
		Map<String,Object> model=new HashMap<String,Object>();
		model.put("errorMsg", e.getMessage());
		return new ModelAndView("/pages/program/errorpage",model);
	}
	


}
