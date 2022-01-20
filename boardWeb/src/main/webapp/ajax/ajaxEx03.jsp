<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script>
	function callJSON(){
		$.ajax({
			url : "data/json/data1.json",
			type : "get",
			success : function(data){
				alert("통신 성공!");
				console.log(data);
				for(var i=0;i<data.length;i++){
					console.log(data[i].name);
					$("#result").html($("#result").html()+data[i].name+"<br>");
				}
			},
			error : function(xhr,status,error){
				alert("통신 오류!!");
			}
			
		});
	}
	
	function callXML(){
		$.ajax({
			url : "data/xml/data1.xml",
			type : "get",
			success : function(data){
				alert("통신 성공!");
				console.log(data);
				var jXML = $(data);
				console.log(jXML);
				jXML.find("book").each(function(){
					var name = $(this).find("name").text();
					console.log(name);
				});
			},
			error : function(){
				alert("통신 오류!!");
			}
		
			
		});
	}
</script>
</head>
<body>
	<h2>jQuery를 이용한 ajax</h2>
	<button onclick="callJSON()">json</button>
	<button onclick="callXML()">xml</button>
	<div id="result"></div>
</body>
</html>