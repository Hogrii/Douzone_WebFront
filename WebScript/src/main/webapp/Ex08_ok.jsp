<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> 
<% 
	// Java 코드 // 요청 ---- 응답 
	String id =	request.getParameter("txtuserid"); 
	String pwd = request.getParameter("txtpwd");
	
	// 로직
	// DB연결 >> select >> id, pwd 존재확인 >> 있으면 >> 요청 페이지 전달
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
  </head>
  <body>
  	서버확인(Client 전달 ... 연습 id, pwd)<br>
  	당신이 입력한 ID : <%= id %><br> <!-- = : responseWrite -->
  	당신이 입력한 PWD : <%= pwd %><br>
  </body>
</html>
