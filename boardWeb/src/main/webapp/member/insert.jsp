<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		<h2>회원 등록</h2>
		<article>
			<form action="insertOk.jsp" method="post">
				<table border="1">
					<tr>
						<th>아이디</th>
						<td><input type="text" name="memberid"></td>
						<th>비밀번호</th>
						<td><input type="text" name="memberpwd"></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="membername"></td>
						<th>나이</th>
						<td><input type="text" name="age"></td>
					</tr>
					<tr>
						<th>성별</th>
						<td>
							<select name="gender" width="40px">
								<option value="M">M</option>
								<option value="F">F</option>
							</select>
						</td>
						<th>지역</th>
						<td><input type="text" name="addr"></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td><input type="text" name="phone"></td>
						<th>이메일</th>
						<td><input type="text" name="email"></td>
					</tr>
				</table>
				<input type="button" value="취소" onclick="location.href='list.jsp'">
				<input type="submit" value="등록">
			</form>
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>

<!--MIDX,MEMBERID,MEMBERPWD,MEMBERNAME,GENDER,ADDR,AGE,PHONE,EMAIL,IP,WRITEDAY,DELYN-->