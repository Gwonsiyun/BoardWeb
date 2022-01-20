<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function callString(){
		var request = new XMLHttpRequest();
		request.onreadystatechange = function(){
			if(request.readyState == 4){
				if(request.status == 200){
					document.getElementById("result").innerHTML = request.responseText;
				}else{
					
				}
			}
		}
		
		
		
		
		//open 메소드의 세번째 인자는 비동기 여부로
		//true - 요청에 대한 응답을 기다리지 않고 처리하다 응답이 오면 처리
		//false - 요청에 대한 응답을 기다린 후 응답이 오면 처리
		request.open("GET","data/html/data1.html",false);
		
		request.send();
		
	}
	function callHTML(){
		var request = new XMLHttpRequest();
		request.onreadystatechange = function(){
			if(request.readyState == 4 && request.status == 200){
				document.getElementById("result").innerHTML = request.responseText;
			}
		}
		request.open("GET","data/html/data2.html",false);
		request.send();
	}
</script>
</head>
<body>
	<h2>ajax 예제</h2>
	<button onclick="callString()">String call</button>
	<button onclick="callHTML()">html call</button>
	<div id="result">
		
	</div>
</body>
</html>