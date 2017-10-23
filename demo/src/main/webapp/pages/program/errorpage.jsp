<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>


<html>
<head>
<title>error page</title>
<body>

oops!Here is the error:
<br>
${errorMsg}

<a href="/login">back to login</a>

</body>
</html>