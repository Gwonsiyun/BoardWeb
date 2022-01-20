<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%
	String bidx_ = request.getParameter("bidx");
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update board set delyn='Y'where bidx="+bidx_;
		
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();
		
		out.print(result);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn);
	}


%>