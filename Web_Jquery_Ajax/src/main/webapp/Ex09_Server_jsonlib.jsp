<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSON"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.kosa.dto.Emp"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//CORS
	//비동기 작업 : 다른 출처 허용 안되요
	//('Access-Control-Allow-origin', '*');
    //https://inpa.tistory.com/entry/WEB-%F0%9F%93%9A-CORS-%F0%9F%92%AF-%EC%A0%95%EB%A6%AC-%ED%95%B4%EA%B2%B0-%EB%B0%A9%EB%B2%95-%F0%9F%91%8F
    //참고 사이트
	response.addHeader("Access-Control-Allow-Origin", "*"); // *(모든) 요청에 대해서 허용해줄거야!
	// 만약 이걸 안해주면 클라이언트는 2가지 방법으로 데이터를 얻을 수 있음
	// 1. 크롤링
	// 2. 전화해서 부탁하기..
	
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = null; //Connection 인터페이스 ...
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","kosa","1004");
	
	Statement stmt = conn.createStatement(); //명령 객체 얻어오기
	String sql = "select empno , ename , sal , job ,comm from emp";
	ResultSet rs = stmt.executeQuery(sql); //DB서버에서 실행되고 결과를 생성
	
	//POINT
	//DTO 객체 데이터 담아야 -> JSON변환 가능
	List<Emp> list = new ArrayList<Emp>();
	
	while(rs.next()){
		Emp emp = new Emp();
		emp.setEmpno(rs.getInt("empno"));
		emp.setEname(rs.getString("ename"));
		emp.setSal(rs.getInt("sal"));
		emp.setJob(rs.getString("job"));
		emp.setComm(rs.getInt("comm"));
		
		list.add(emp);
	}
	/*
	for(Emp e : list){
		System.out.println(e.toString());
	}	
	*/
	
	// [{},{},{},{},.....]
	//String json = "[" + "{" + "empno :" + rs.get		

	
	// net.sf.json.JSONArray >> 서버쪽 데이터를 json 형태로 가공하기
	JSONArray jsonlist = JSONArray.fromObject(list); // 한줄로 end
		
	stmt.close();
	rs.close();
	conn.close();	
	
	/*
	주의 사항
	JSONArray :. java.lang.reflect.InvocationTargetException로 변환 할 때
	java.sql.Date java.util.Date의 오류 net.sf.json.JSONException에 할당
	JSONLIB 가 Date 형식 인지하지 못해요
	
	그래서 Date > to_char() 형식으로 변환 하세요
	*/
%>
<%=jsonlist%>
