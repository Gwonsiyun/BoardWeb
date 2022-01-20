<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String memberpwd_ = request.getParameter("memberpwd");
	String addr_ = request.getParameter("addr");
	String phone_ = request.getParameter("phone");
	String email_ = request.getParameter("email");
	String midx_ =request.getParameter("midx");
	
	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt =null;
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " update member set memberpwd='"+memberpwd_+"', addr='"+addr_+"', phone='"+phone_+"', email='"+email_+"' where midx= "+midx_;
		
		psmt = conn.prepareStatement(sql);
		
		int result = psmt.executeUpdate();
		
		if(result>0){
			response.sendRedirect("view.jsp?midx="+midx_);
		}else{
			response.sendRedirect("list.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
	}
	

%>