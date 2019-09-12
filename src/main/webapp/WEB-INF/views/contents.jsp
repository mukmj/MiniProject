<%@page import="com.java.web.FileBean"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.java.web.WriteBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    div{
        width: 500px;
    }
    
    ul {
        list-style: none;
    }
    
    .line {
        border-bottom: 1px solid #bababa;
        box-sizing: border-box;
    }
    
    .butt {
    	margin-top: 50px;
    	margin-left: 40px;
    }
    
    .right {
    	float: right;
    }
    
    .butStyle {
    	border: none;
    	border: 1px solid grey;
    	border-bottom-right-radius: 5px; 
    	cursor: pointer;
    	background-color: white;
    	margin-top: 5px;
    }
    
    .butStyle:hover {
		background-color: grey;
	}
</style>
    
<script>
	function mainHome(){
		location.href = "/main";
	}
</script>
<title>자세히보기</title>
</head>
<body>
<%
	List<WriteBean> wb = (List<WriteBean>)request.getAttribute("wb");
	List<FileBean> fbList = (List<FileBean>) request.getAttribute("fileList");
%>
    <div>
        <ul>
            <li class="line">제목: <%=wb.get(0).getTitle()%></li>
        </ul>
        <ul>
            <li class="line">내용</li>
<%
	if(wb.get(0).getComment() != null){
%>
            <li><%=wb.get(0).getComment()%></li>
<%
	}
%>
        </ul>
        <ul style="margin-top: 50px;">
            <li class="line">첨부파일</li>        
<%
	if(fbList != null){
		for(int i = 0 ; i < fbList.size(); i++){
%>
		 <form action="/download/<%=i%>">
            	<input type="hidden" name="no" value="<%=wb.get(0).getNo()%>">
            	<button type="submit" class="butStyle"><%=fbList.get(i).getFileName()%></button>
         </form>
<%
		}
	}
%>
        </ul>
    </div>
    <div class="butt">
    	<button type="button" onclick="mainHome()">목록</button>
    	<form class="right">
			<input type="hidden" name="contentNo" value="<%=wb.get(0).getNo()%>">
<%
	HashMap<String, String> nick = (HashMap<String, String>)request.getAttribute("nick");
	if(nick.get("nickname") == nick.get("originalNick")) {
%>	
			<input type="submit" value="수정" id="update" formaction="/updateMove">
			<input type="submit" value="삭제" formaction="/delete">
<%
	}
%>
	</form>
    </div>
</body>
</html>