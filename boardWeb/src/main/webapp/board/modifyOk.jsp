<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String subject=request.getParameter("subject");
	String content=request.getParameter("content");
	String bidx=request.getParameter("bidx");

	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	//ResultSet rs = null;
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " update board set subject= '"+subject+"' "+",content= '"+content+"' "+"where bidx= "+bidx;
		//"update board set subject=??, content=?? where bidx=?"
				
		psmt = conn.prepareStatement(sql);
		
		int result =psmt.executeUpdate();
		
		if(result>0){
			//out.print("<script>alert('수정완료!')</script>");
			response.sendRedirect("view.jsp?bidx="+bidx);
		}else{
			//out.print("<script>alert('수정실패!')</script>");
			response.sendRedirect("list.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
%>