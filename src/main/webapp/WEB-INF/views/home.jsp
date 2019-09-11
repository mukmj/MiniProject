<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    div {
        height: 50vh;
        width: 600px;
    }
    
    ul{
        height: 23px;
        padding: 0;
        clear: both;
        margin: 0;
    }
    
    li {
        width: 200px;
        list-style: none;
        float: left;
        text-align: center;
        border: 1px solid grey;
        box-sizing: border-box;
    }
    
    div {
        text-align: end;
        padding-top: 20px;
    }
</style>
    
<script>
	function move(){
		location.href="/insert";
	}
</script>
<title>Main</title>
</head>
<body>
    <h1>게시판</h1> 
    <div>
        <ul>
            <li>번호</li>
            <li>제목</li>
            <li>작성자</li>
        </ul>
        <ul>
            <li>1</li>
            <li>asd</li>
            <li>asd</li>
        </ul>
        
		<div>
        	<button type="submit" onclick="move()">추가</button>
		</div>
    </div>

</body>
</html>