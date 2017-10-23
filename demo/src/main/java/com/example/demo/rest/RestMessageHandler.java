package com.example.demo.rest;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import sun.misc.BASE64Encoder;

import com.example.demo.AccountService;
import com.example.demo.domain.SsoLog;

@RestController
public class RestMessageHandler {

	@Autowired
	private AccountService account;

	// @RequestMapping("/log")
	// SsoLog showLog() {
	// return account.getSsoLog();
	// }

	@RequestMapping("/visit/{function}")
	String showMeYourPage(@PathVariable String function) {
		return "hi";
	}

	@RequestMapping("/logtest")
	SsoLog showLogNew() {
		return account.getSsoLogNew();
	}

	@RequestMapping(value = "/showlog/{tokenid}", method = RequestMethod.GET)
	SsoLog showLogDev(@PathVariable String tokenid) {
		return account.getSsoLogDev(tokenid);
	}

	public static void main(String[] a) throws UnsupportedEncodingException {
		String encryptedCharactors = Base64.getEncoder().encodeToString(
			    "aq5Fladk8TKZ6_IXC9jCYWyUFTUa:3Lf7fXzmDm7p6gpz2o0fN3c9aBoa".getBytes(StandardCharsets.UTF_8));
		System.out.println(encryptedCharactors);
		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		MediaType type = MediaType.parseMediaType("application/x-www-form-urlencoded;charset=utf-8");
		headers.setContentType(type);
		headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE.toString());  
		headers.add("Authorization","Basic "+encryptedCharactors);
		Map<String,String> map=new HashMap<String,String>();
		map.put("grant_type", "client_credentials");
//		map.put("ConsumerKey", "aq5Fladk8TKZ6_IXC9jCYWyUFTUa");
//		map.put("ConsumerSecret", "3Lf7fXzmDm7p6gpz2o0fN3c9aBoa");

		JSONObject.fromObject(map);
		HttpEntity<String> formEntity = new HttpEntity<String>(JSONObject.fromObject(map).toString(), headers);

		JSONObject result = restTemplate.postForObject("https://soa-test.lenovo.com/api/oauth2/token", formEntity, JSONObject.class);
		System.out.println(result);

	}

}
