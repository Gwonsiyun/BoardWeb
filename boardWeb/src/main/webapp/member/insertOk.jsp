<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	String memberid = request.getParameter("memberid");
	String memberpwd  = request.getParameter("memberpwd");
	String membername  = request.getParameter("membername");
	String age = request.getParameter("age");
	String gender  = request.getParameter("gender");
	String addr  = request.getParameter("addr");
	String phone  = request.getParameter("phone");
	String email  = request.getParameter("email");
	
	String url	= "jdbc:oracle:thin:@localhost:1522:xe";
	String user	= "system";
	String pass	= "1234";
	
	Connection conn	= null;
	PreparedStatement psmt = null;
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql= " insert into member(midx,memberid,memberpwd,membername,age,gender,addr,phone,email) values(midx_seq.nextval,?,?,?,?,?,?,?,?)";
		//로그인이 아직 없어서 midx를 직접 기입함
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,memberid);
		psmt.setString(2,memberpwd);
		psmt.setString(3,membername);
		psmt.setString(4,age);
		psmt.setString(5,gender);
		psmt.setString(6,addr);
		psmt.setString(7,phone);
		psmt.setString(8,email);
		
		
		int result = psmt.executeUpdate();
		
		response.sendRedirect("list.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>