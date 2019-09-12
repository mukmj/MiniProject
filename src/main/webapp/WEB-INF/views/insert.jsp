<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.java.web.WriteBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    .container {
        margin-top: 30px;
        height: 50vh;
        width: 550px;
    }
    
    .miniTitle {
        display: block;
        margin-bottom: 10px;
        margin-top: 50px;
    }
    
    #comment {
        width: 500px;
        height: 200px;
    }
    
    #but {
        margin-top: 30px;
    }
</style>

<title>Main</title>
</head>
<body>
<%
	List<WriteBean> wb = (List<WriteBean>) request.getAttribute("wb");
%>
    <div class="container">
        <form action="/input" method="POST" onsubmit="return butEvent()" enctype="multipart/form-data">
            <div>
                <label>제목: </label>
                <input type="text" name="title" id="title">
            </div>
            <div>
                <label class="miniTitle">내용</label>
                <textarea id="comment" name="comment"></textarea>
            </div>
	        <div>
                <label class="miniTitle">첨부파일</label>
                <input type="file" name="file" id="file" multiple=multiple>
            </div> 
	<%
		if(wb == null){
	%>
            <input type="submit" id="but" value="추가">
    <%
		} else {
    %>
    		<input type="hidden" id="tit" value="<%=wb.get(0).getTitle()%>">
    		<input type="hidden" id="com" value="<%=wb.get(0).getComment()%>">
    		<script>
    			document.getElementById("title").value = document.getElementById("tit").value;
    			document.getElementById("comment").value = document.getElementById("com").value;
    		</script>
     		<input type="submit" id="but" value="수정" formaction="/update">
    <%
		}
    %>
    		<button type="button" onclick="reHome()">취소</button>
    		<input type="hidden" id="urlNo" name="urlNo">
        </form> 
    </div>
</body>
<script>
	var url = document.location.href.split("=")[1];
	console.log(url)
	document.getElementById("urlNo").value = url; 
	
	function butEvent(){
		var tit = document.getElementById("title");
		var comment = document.getElementById("comment");
		var file = document.getElementById("file");
		
		if(tit.value == ""){
			tit.setAttribute('style','border:1px solid red');
			alert("[제목]을 작성해주세요.");
			return false;
		}else if(comment.value == "" && file.files.length == 0){
			alert("[내용] 또는 [첨부파일] 둘중에 하나라도 추가해주세요.")
			return false;
		}
	}
	
	function reHome(){
		location.href = "/main";
	}
</script>
</html>