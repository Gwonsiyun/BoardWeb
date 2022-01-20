<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.sql.*"%>
<%
	String bidx_ = request.getParameter("bidx");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "select * from board where bidx=?";
	
		psmt = conn.prepareStatement(sql);
		psmt.setString(1,bidx_);
		
		
		rs = psmt.executeQuery();
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject jObj = new JSONObject();
			jObj.put("subject",rs.getString("subject"));
			jObj.put("writer",rs.getString("writer"));
			jObj.put("content",rs.getString("content"));
			jObj.put("bidx",rs.getInt("bidx"));
			jObj.put("midx",rs.getInt("midx"));
			
			list.add(jObj);
		}
		
		out.print(list.toJSONString());
		
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt, conn, rs);
	}


%>