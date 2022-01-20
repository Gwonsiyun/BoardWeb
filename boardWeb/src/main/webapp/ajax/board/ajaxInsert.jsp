<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String subject = request.getParameter("subject");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "insert into board(bidx,subject,writer,content,midx)"+
					" values(bidx_seq.nextval,?,?,?,1)";
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,subject);
		psmt.setString(2,writer);
		psmt.setString(3,content);
		
		int result = psmt.executeUpdate();
		
		sql = "select * from board where bidx = (select max(bidx) from board)";
		
		psmt = null;
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject obj = new JSONObject();
			
			obj.put("bidx",rs.getInt("bidx"));
			obj.put("subject",rs.getString("subject"));
			obj.put("writer",rs.getString("writer"));
			
			list.add(obj);
		}
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}

%>