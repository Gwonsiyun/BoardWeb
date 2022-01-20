<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ridx_ = request.getParameter("ridx");
	String rcontent_ = request.getParameter("rcontent");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update reply set rcontent='"+rcontent_+"' where ridx="+ridx_;
		
		psmt = conn.prepareStatement(sql);
		
		psmt.executeUpdate();
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn);
	}


%>