<%@page import="boardWeb.util.PagingUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%
	Member login = (Member)session.getAttribute("loginUser");
%>
<%
	request.setCharacterEncoding("UTF-8");

	//searchValue 가 null이면 검색버튼을 누르지 않고 화면으로 들어옴.
	String searchValue= request.getParameter("searchValue");
	String searchType= request.getParameter("searchType");
	
	String nowPage= request.getParameter("nowPage");
	int nowPageI = 1;
	if(nowPage != null){
		nowPageI = Integer.parseInt(nowPage);
	}
	

	String url = "jdbc:oracle:thin:@localhost:1522:xe";
	String user = "system";
	String pass= "1234";
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	
	PagingUtil paging = null;
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url,user,pass);
		//String sql = "select * from board order by originbidx asc,depth asc";
		String sql = "";
		
		sql = "select count(*) as total from board ";
		if(searchValue!=null && !searchValue.equals("") && !searchValue.equals("null")){
			if(searchType.equals("subject")){
				sql += " where subject like '%"+searchValue+"%'";
			}else if(searchType.equals("writer")){
				sql += " where writer = '"+searchValue+"'";
			}
			
		}
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt .executeQuery();
		int total =0;
		if(rs.next()){
			total = rs.getInt("total");
		}
		
		paging = new PagingUtil(total,nowPageI,5);
		
		
		
		sql = " select * from ";
		sql += " (select rownum r , b.* from";
		sql += " (select * from board where delyn='N'";
		
		if(searchValue!=null && !searchValue.equals("") && !searchValue.equals("null")){
			if(searchType.equals("subject")){
				sql += " and subject like '%"+searchValue+"%'";
			}else if(searchType.equals("writer")){
				sql += " and writer like '%"+searchValue+"%'";
			}
			
		}
		
		sql += " order by bidx desc ) b)";
		sql += " where r>="+paging.getStart()+" and r<="+paging.getEnd();
		
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
						<option value="subject" <%if(searchType != null && searchType.equals("subject")) out.print("selected");%>>글제목</option>
						<option value="writer" <%if(searchType != null && searchType.equals("writer")) out.print("selected");%>>작성자</option>
					
					<%-- 	
						<%
						if(searchType != null){
							if(searchType.equals("subject")){
						%>
							<option value="subject" selected>글제목</option>
							<option value="writer">작성자</option>
						<%	
							}else if(searchType.equals("writer")){
						%>		
							<option value="subject">글제목</option>
							<option value="writer" selected>작성자</option>
						<%		
							}
						}else{
						%>
							<option value="subject">글제목</option>
							<option value="writer">작성자</option>
						<%} %>
					--%>
					</select>
					<input type="text" name="searchValue"<%if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")) out.print("value='"+searchValue+"'");%>>
					
					<%-- <%
						if(searchValue != null){
					%>
						<input type="text" name="searchValue" value="<%=searchValue%>">
					<%	
						}else{
					%>
						<input type="text" name="searchValue">
					<%
						}
					%> --%>
					<!-- <input type="text" name="searchValue">검색어 유지 추가 -->
					
					<input type="submit" value="검색">
				</form>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
					</tr>
				</thead>
				<tbody>
				<%
					while(rs.next()){
				%>
						<tr>
							<td><%=rs.getInt("bidx") %></td>
							<td><a href="view.jsp?bidx=<%=rs.getInt("bidx") %>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%=rs.getString("subject") %></a></td>
							<td><%=rs.getString("writer") %></td>
						</tr>
				<%
					}
				%>						
				</tbody>
			</table>
			
			<!-- 페이징 영역 -->
			<div id="pagingArea">
			<%if(paging.getStartPage()>1){ %>
				<a href="list.jsp?nowPage=<%=paging.getStartPage()-1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&lt;</a>
				
				
			<%} %>	
			
			<%for(int i= paging.getStartPage(); i<=paging.getEndPage();i++){ 
				if(i == paging.getNowPage()){
			%>
				<b><%= i %></b>
			<% 		
				}else{
			%>
				<a href="list.jsp?nowPage=<%=i%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>"><%= i %></a>
				<%} %>
				
			<%} %>
			
			<%if(paging.getEndPage() != paging.getLastPage()){ %>
				<a href="list.jsp?nowPage=<%=paging.getStartPage()+1%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>">&gt;</a>
				
				
			<%} %>
			</div>
			
			
			
			<%if(login != null){%>
			<button onclick="location.href='insert.jsp'">등록</button>
			<%}%>
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