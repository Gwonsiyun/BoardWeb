<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");	//인코딩 타입 변환

	//searchValue 가 null이면 검색버튼을 누르지 않고 화면으로 들어옴.
	String searchValue= request.getParameter("searchValue");
	String searchType= request.getParameter("searchType");

	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "system";
	String pass= "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		//String sql = "select * from member order by originbidx asc,depth asc";
		String sql = "select * from member";
		
		if(searchValue!=null && !searchValue.equals("")){
			if(searchType.equals("membername")){
				sql += " where membername like '%"+searchValue+"%'";
			}else if(searchType.equals("addr")){
				sql += " where addr like '%"+searchValue+"%'";
			}else if(searchType.equals("gender")){
				sql += " where gender = '"+searchValue+"'";
			}else if(searchType.equals("email")){
				sql += " where email like '%"+searchValue+"%'";
			}
			sql +=  "and delyn='N'";
		}
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
	
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<h2>게시글 목록</h2>
		<article>
			<div class="searchArea">
				<form action="list.jsp">
					<select name ="searchType">
						<option value="membername" <%if(searchType!=null && searchType.equals("membername")) out.print("selected");%>>이름</option>
						<option value="addr" <%if(searchType!=null && searchType.equals("addr")) out.print("selected");%>>주소</option>
						<option value="gender" <%if(searchType!=null && searchType.equals("gender")) out.print("selected");%>>성별</option>
						<option value="email" <%if(searchType!=null && searchType.equals("email")) out.print("selected");%>>이메일</option>
					</select>
					<input type="text" name="searchValue" <%if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")) out.print("value='"+searchValue+"'");%>>
					<input type="submit" value="검색">
				</form>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>회원번호</th>
						<th>회원아이디</th>
						<th>회원이름</th>
						<th>성별</th>
						<th>나이</th>
						<th>전화번호</th>
						<th>이메일</th>
						<th>주소</th>
					</tr>
				</thead>
				<tbody>
				<%
					while(rs.next()){
						
					/*
						각 회원명 클릭시 상세페이지 이동할 수 있도록 구현하세요.
						view.jsp생성
						회원 아이디, 회원 비밀번호, 회원 명, 주소, 연락처, 이메일을 테이블로 출력
					
					*/
						
				%>
						<tr>
							<td><%=rs.getInt("midx") %></td>
							<td><%=rs.getString("memberid") %></td>
							<td><a href="view.jsp?midx=<%=rs.getInt("midx") %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=rs.getString("membername") %></a></td>
							<td><%=rs.getString("gender") %></td>
							<td><%=rs.getString("age") %></td>
							<td><%=rs.getString("phone") %></td>
							<td><%=rs.getString("email") %></td>
							<td><%=rs.getString("addr") %></td>
						</tr>
				<%
					}
				%>						
				</tbody>
			</table>
			<button onclick="location.href='insert.jsp'">등록</button>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>
<%
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn!=null){
			conn.close();
		}
		if(psmt!=null){
			psmt.close();
		}
		if(rs!=null){
			rs.close();
		}
	}
%>