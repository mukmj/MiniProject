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
%>
    <div>
        <ul>
            <li class="line">제목: <%=wb.get(0).getTitle()%></li>
        </ul>
        <ul>
            <li class="line">내용</li>
            <li><%=wb.get(0).getComment()%></li>
        </ul>
        <ul style="margin-top: 50px;">
            <li class="line">첨부파일</li>
        </ul>
    </div>
    <div class="butt">
    	<button type="button" onclick="mainHome()">목록</button>
    </div>
    
	<form>
		<input type="hidden" name="contentNo" value="<%=wb.get(0).getNo()%>">
		<input type="submit" value="삭제" formaction="/delete">
 		<input type="submit" value="수정" formaction="/updateMove">
	</form>
   

</body>
</html>