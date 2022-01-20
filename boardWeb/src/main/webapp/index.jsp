<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.vo.*" %>
<%
	Member login = (Member)session.getAttribute("loginUser");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script>
	function goMember(){
		var login = '<%=login%>';
		
		console.log(login);
		console.log(typeof login);
		//location.href = "member/list.jsp";
		
		if(login == 'null'){
			alert("로그인 후 접근 가능하십니다.");
		}else{
			location.href = "member/list.jsp";
		}
		
	}
</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<a href="board/list.jsp">게시판으로 이동</a>
		<a href="javascript:goMember();">회원게시판으로 이동</a>
		
		<%
			if(login != null){
		%>
			<h2><%=login.getMembername() %>님 로그인을 환영합니다.</h2>
		<%	
			}
		%>
		
		<!-- 
			회원 게시판에서 검색 기능 추가 회원명이 일치하는 경우 검색 과 주소 부분 검색 기능
			ex) 콤보박스에 이름을 두고 홍길동이라 입력하면 모든 홍길동 조회
				콤보박스에 주소로 두고 전주시라 입력하면 주소에 전주시를 가지는 모든 데이터 조회
		 -->
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>