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
    <div class="container">
        <form action="/input" method="POST" enctype="multipart/form-data">
            <div>
                <label>제목: </label>
                <input type="text" name="title">
            </div>
            <div>
                <label class="miniTitle">내용</label>
                <textarea id="comment" name="comment"></textarea>
            </div>
	        <div>
                <label class="miniTitle">첨부파일</label>
                <input type="file" name="file" onchange="file_Event(this)" multiple=multiple>
            </div> 
            <input type="submit" id="but">
        </form>      
    </div>
</body>
</html>