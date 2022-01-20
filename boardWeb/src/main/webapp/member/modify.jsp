<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String midx = request.getParameter("midx");

	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String memberid_ = "";
	String memberpwd_ = "";
	String membername_ = "";
	String addr_ = "";
	String phone_ = "";
	String email_ = "";
	int midx_ = 0;
	
	try{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from member where midx="+midx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			memberid_ = rs.getString("memberid");
			memberpwd_ = rs.getString("memberpwd");
			membername_ = rs.getString("membername");
			addr_ = rs.getString("addr");
			phone_ = rs.getString("phone");
			email_ = rs.getString("email");
			midx_ = rs.getInt("midx");
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null) conn.close();
		if(psmt != null) psmt.close();
		if(rs != null) rs.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href ="<%=request.getContextPath() %>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<h2>회원 상세정보</h2>
		<article>
			<form action="modifyOk.jsp" method="post">
				<input type="hidden" name="midx" value="<%=midx_%>">
				<table border="1">
					<tr>
						<th>아이디</th>
						<td><%=memberid_ %></td>
						<th>비밀번호</th>
						<td><input type="text"	name="memberpwd" value="<%=memberpwd_ %>"></td>
					</tr>
					<tr>
						<th>회원명</th>
						<td><%=membername_ %></td>
						<th>주소</th>
						<td><input type="text"	name="addr" value="<%=addr_ %>"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="text" name="phone" value="<%=phone_ %>"></td>
						<th>이메일</th>
						<td><input type="text" name="email" value="<%=email_ %>"></td>
					</tr>
				</table>
				<button type="button" onclick="location.href='view.jsp?midx=<%=midx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
				<button type="submit">저장</button>
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>