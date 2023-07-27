package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class cookies {

	public static String getCookies(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
  
    	for(Cookie c: cookies){
    		if(c.getName().equals("userData")){
    			return c.getValue();
    		}
    	}
    	
    	return null;
	}
}
