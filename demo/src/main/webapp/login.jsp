<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<html>
<head>
<title>login page</title>
<body>

	<form action="/login" method="post">
		<input type="text" name="username" value="user"/> 
		<input type="text" name="password" value="password"/> 
		<input type="submit" value="Sign In" />
	</form>
</body>
</html>