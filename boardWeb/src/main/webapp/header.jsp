<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
	Member m = (Member)session.getAttribute("loginUser");
%>   
<header>
	<h1><a href="<%=request.getContextPath()%>">게시판 만들기</a></h1>
	<%if(m == null){ %>
	<div class="loginArea">
		<a href="<%=request.getContextPath()%>/login/login.jsp">로그인</a>
		|
		<a href="<%=request.getContextPath()%>/login/join.jsp">회원가입</a>
	</div>
	<% 
	}else{
	%>
	<div class="loginArea">
		<a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a>
		|
		<a href="<%=request.getContextPath()%>/login/mypage.jsp">마이페이지</a>
	</div>
	<%} %>
</header>