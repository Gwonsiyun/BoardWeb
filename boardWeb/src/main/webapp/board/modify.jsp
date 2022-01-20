<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String bidx = request.getParameter("bidx");

	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "system";
	String pass = "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String subject_ = "";
	String writer_ = "";
	String content_ = "";
	int bidx_ = 0;
	
	try{
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		
		String sql = " select * from board where bidx="+bidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			subject_ = rs.getString("subject");
			writer_ = rs.getString("writer");
			content_ = rs.getString("content");
			bidx_ = rs.getInt("bidx");
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
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<h2>게시글 상세조회</h2>
		<article>
			<form action="modifyOk.jsp" method="post">
				<input type="hidden" name="bidx" value="<%=bidx_ %>">
				<table border="1" width="70%">
					<tr>
						<th>글제목</th>
						<td colsqan="3"><input type="text" sie="50" name="subject" value="<%=subject_%>"></td>
					</tr>
					<tr>
						<th>글번호</th>
						<td><%=bidx_ %></td>
						<th>작성자</th>
						<td><%=writer_ %></td>
					</tr>
					<tr height = "300px">
						<th>내용</th>
						<td colspan="3"><textarea name="content"><%=content_ %></textarea></td>
					</tr>
				</table>
				<button type="button" onclick="location.href='view.jsp?bidx=<%=bidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">취소</button>
				<button type="submit">저장</button>
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>