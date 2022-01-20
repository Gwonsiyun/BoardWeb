<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="boardWeb.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String bidx_ = request.getParameter("bidx");
	String subject_ = request.getParameter("subject");
	String writer_ = request.getParameter("writer");
	String content_ = request.getParameter("content");
	
	Connection conn = null;
	PreparedStatement psmt = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "update board set subject='"+subject_+"'"+",content='"+content_+"'"+",writer='"+writer_+"'"+"where bidx="+bidx_;
		
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();
		
		out.print(result);
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn);
	}


%>