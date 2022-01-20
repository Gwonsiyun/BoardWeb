<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="boardWeb.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="org.json.simple.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String rcontent_ = request.getParameter("rcontent");
	String midx_ = request.getParameter("midx");
	String bidx_ = request.getParameter("bidx");
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	try{
		conn = DBManager.getConnection();
		
		String sql = "insert into reply(ridx,bidx,rcontent,midx)"+
					" values(ridx_seq.nextval,?,?,?)";
		psmt = conn.prepareStatement(sql);
		
		psmt.setString(1,bidx_);
		psmt.setString(2,rcontent_);
		psmt.setString(3,midx_);
		
		int result = psmt.executeUpdate();
		
		sql = "select * from reply r, member m where r.midx = m.midx and r.ridx = (select max(ridx) from reply)";
		
		psmt = null;
		
		psmt = conn.prepareStatement(sql);
		
		rs = psmt.executeQuery();
		
		
		JSONArray list = new JSONArray();
		if(rs.next()){
			JSONObject obj = new JSONObject();
			
			obj.put("rcontent",rs.getString("rcontent"));
			obj.put("membername",rs.getString("membername"));
			obj.put("ridx",rs.getInt("ridx"));
			
			list.add(obj);	
		
		}
		out.print(list.toJSONString());
		
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		DBManager.close(psmt,conn,rs);
	}

%>