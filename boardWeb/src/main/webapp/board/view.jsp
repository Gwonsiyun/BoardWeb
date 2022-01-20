<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="boardWeb.vo.*" %>
<%@ page import="boardWeb.util.*" %>
<%@ page import="java.util.*" %>
<%
	Member user_ = (Member)session.getAttribute("loginUser");
		
%>
<%
	request.setCharacterEncoding("UTF-8");
	String searchType = request.getParameter("searchType");
	String searchValue = request.getParameter("searchValue");
	
	String bidx= request.getParameter("bidx");
	
	Connection conn	= null;
	PreparedStatement psmt = null;
	ResultSet rs	= null;
	
	PreparedStatement psmtReply = null;
	ResultSet rsReply	= null;
	
	String subject_ = "";
	String writer_ = "";
	String content_ = "";
	int bidx_ = 0;
	int midx_ = 0;
	
	ArrayList<Reply> rList = new ArrayList<>();
	
	try{
		
		conn = DBManager.getConnection();
		
		String sql = " select * from board where bidx = "+bidx;
		
		psmt = conn.prepareStatement(sql);
		rs = psmt.executeQuery();
		
		if(rs.next()){
			subject_ = rs.getString("subject");
			writer_ = rs.getString("writer");
			content_ = rs.getString("content");
			bidx_ = rs.getInt("bidx");
			midx_ = rs.getInt("midx");
		}
		
		sql = "select * from reply r, member m WHERE r.midx = m.midx AND r.bidx = "+bidx;
		
		psmtReply = conn.prepareStatement(sql);
		
		rsReply = psmtReply.executeQuery();
		
		
		
		
		while(rsReply.next()){
			Reply reply = new Reply();
			reply.setBidx(rsReply.getInt("bidx"));
			reply.setMidx(rsReply.getInt("midx"));
			reply.setRidx(rsReply.getInt("ridx"));
			reply.setRcontent(rsReply.getString("rcontent"));
			reply.setRdate(rsReply.getString("rdate"));
			reply.setMembername(rsReply.getString("membername"));
			
			rList.add(reply);
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn != null){
			conn.close();		
		}
		if(psmt != null){
			psmt.close();		
		}
		if(rs != null){
			rs.close();		
		}
		if(psmtReply != null) psmtReply.close();
		if(rsReply != null) rsReply.close();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<%=request.getContextPath()%>/css/base.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<section>
		<h2>게시글 상세조회</h2>
		<article>
			<table border="1" width="70%">
				<tr>
					<th>글제목</th>
					<td colsqan="3"><%=subject_ %></td>
				</tr>
				<tr>
					<th>글번호</th>
					<td><%=bidx_ %></td>
					<th>작성자</th>
					<td><%=writer_ %></td>
				</tr>
				<tr height = "300px">
					<th>내용</th>
					<td colspan="3"><%=content_ %></td>
				</tr>
			</table>
			<button type="button" onclick="location.href='list.jsp?searchType=<%=searchType%>&searchValue=<%=searchValue%>'">목록</button>
			<%if(user_!= null && user_.getMidx() == midx_){ %>
			<button type="button" onclick="location.href='modify.jsp?bidx=<%=bidx_%>&searchType=<%=searchType%>&searchValue=<%=searchValue%>'">수정</button>
			<button type="button" onclick="deleteFn()">삭제</button>
			<%} %>
			<form name="frm" method="post">
				<input type="hidden" name="bidx" value="<%=bidx_%>">
			</form>
			
			<div class="replyArea">
				<div class="replyList">
				<table border="1" name=reply>
					<tbody id="reply">
					<%for(Reply r : rList){%>
						<tr>
							<td><%=r.getMembername() %> : </td>
							<td><%=r.getRcontent() %></td>
							<% if(user_!=null && user_.getMidx()== r.getMidx()){%>
							<td>
								<input type="button" onclick='modify(<%=r.getRidx()%>,this)' value="수정">
								<input type="button" onclick='deleteReply(<%=r.getRidx()%>,this)' value="삭제" >
								
							</td>
							<%} %>
						</tr>
					<%}%>
					</tbody>
				</table>
				</div>
			
				<div class="replyInput">
					<form name="reply">
						<p>
							<label>
								내용 : <input type="text" size="50" name="rcontent">
							</label>
						</p>
						<p>
							<input onclick="replyFn()" type="button" value="저장">
						</p>
					</form>
				</div>
				
			</div>
			
			
			
		</article>
	</section>
	<%@ include file="/footer.jsp" %>
	<script>//외부로 빼서 사용(보안상의 이유 삭제페이지정보가 넘어가면 안됨)
		function deleteFn(){
			document.frm.action="deleteOk.jsp";
			document.frm.submit();
		}
		function replyFn(){
			<%if(user_ != null){%>
				$.ajax({
					url : "<%=request.getContextPath()%>/reply/Insert.jsp",
					type : "post",
					data : $("form[name=reply]").serialize()+"&midx="+<%=user_.getMidx()%>+"&bidx="+<%=bidx%>,
					success : function(data){
						console.log(data);
						var json = JSON.parse(data.trim());
						var html="";
						html += "<tr>";
						html += "<td>"+json[0].membername+"</td>";
						html += "<td>"+json[0].rcontent+"</td>";
						html += "<td><input type='button' value='저장' onclick='modify("+json[0].ridx+",this)'> <input type='button' value='삭제' onclick='deleteReply("+json[0].ridx+",this)'></td>";
						html += "</tr>";
						$("tbody#reply").append(html);
					}
				});
			<%}else{%>
				alert("로그인후 이용하여 주세요.");
			<%}%>
		}
		function modify(ridx,obj){
			
			
			if($(obj).val()=="수정"){
				$(obj).parent().prev().html("<input type='text' value='"+$(obj).parent().prev().html()+"'>");
				$(obj).val("저장");
				$(obj).next().val("취소");
			}else if($(obj).val()=="저장"){
				console.log($(obj).parent().prev().children().first().val());
				$.ajax({
					url : "<%=request.getContextPath()%>/reply/modify.jsp",
					type : "post",
					data : "?ridx="+ridx+"&rcontent="+$(obj).parent().prev().children().first().val(),
					success : function(){
						$(obj).parent().prev().html($(obj).parent().prev().children().first().val());
						$(obj).val("수정");
						$(obj).next().val("삭제");
					}
				});
			}
		}
		function deleteReply(ridx,obj){
			console.log(ridx+","+obj);
			var YN = confirm("정말 삭제하시겠습니까?");
			if(YN){
				$.ajax({
					url : "<%=request.getContextPath()%>/reply/deleteOk.jsp",
					type : "post",
					data : "ridx="+ridx,
					success : function(){
						$(obj).parent().parent().remove();
					}
				});
			}
		}
		
	</script>
</body>
</html>