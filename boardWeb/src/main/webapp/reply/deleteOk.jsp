<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%@ page import="boardWeb.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String ridx = request.getParameter("ridx");
	
	
	
	Connection conn = null;
	PreparedStatement psmt =null;

	

	try{
		conn = DBManager.getConnection();
		
		String sql = "delete from reply where ridx ="+ridx;
		
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn);
	}
%>