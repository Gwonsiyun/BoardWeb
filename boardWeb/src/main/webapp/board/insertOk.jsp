<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%
	Member login = (Member)session.getAttribute("loginUser");
%>
<%
	request.setCharacterEncoding("UTF-8");

	String subject = request.getParameter("subject");
	String writer  = request.getParameter("writer");
	String content  = request.getParameter("content");
	
	String url	= "jdbc:oracle:thin:@localhost:1522:xe";
	String user	= "system";
	String pass	= "1234";
	
	Connection conn	= null;
	PreparedStatement psmt = null;
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql= " insert into board(bidx,subject,writer,content,midx) values(bidx_seq.nextval,?,?,?,?)";
		
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,subject);
		psmt.setString(2,writer);
		psmt.setString(3,content);
		psmt.setInt(4,login.getMidx());
		
		int result = psmt.executeUpdate();
		
		response.sendRedirect("list.jsp");
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}


%>