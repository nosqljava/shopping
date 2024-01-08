<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>로그인 처리</title>
  <meta charset="utf-8">
  <script type="text/javascript">
  	function change(no){
  		console.log(no);
  		if(no==1){
  			let ein = document.querySelector('#second');
  			ein.type = 'email';
  			ein.placeholder = 'Enter email';
  		}else{
  			let ein = document.querySelector('#second');
  			ein.type = 'text';
  			ein.placeholder = 'Enter id';
  		}
  	}
  </script>
</head>
<body>
<div class="container mt-5 mx-9">
 
<h2 class='mb-2'>로그인</h2>
  <form 
        action="/member/login"
        method="post">  
    <input type="hidden" name="contentsno" value="${param.contentsno}">     
    <input type="hidden" name="cateno" value="${param.cateno}">     
    <input type="hidden" name="nowPage" value="${param.nowPage}">    
    <input type="hidden" name="col" value="${param.col}">    
    <input type="hidden" name="word" value="${param.word}">
        
    <div class="mb-3 mt-3">
      <label for="id">아이디 </label>
      <div class="col-sm-5">
        <input type="text" class="form-control col-sm-6" id="id" 
        placeholder="Enter id" name="id" required="required" 
        value='${c_id_val}'>
      </div>
    </div>
    <div class="mb-3 mt-3">
      <label for="pwd">비밀번호</label>   
      <div class="col-sm-5">     
        <input type="password" class="form-control" id="pwd" 
        placeholder="Enter password" name="passwd" required="required" >
      </div>
    </div>
    <div class="form-check mb-3">        
 
          <label class="form-check-label">
          <c:choose>
          <c:when test="${c_id =='Y'}">
            <input class="form-check-input" type="checkbox" name="c_id" value="Y" checked="checked"> Remember ID
          </c:when>
          <c:otherwise>
            <input class="form-check-input" type="checkbox" name="c_id" value="Y" > Remember ID
          </c:otherwise>
          </c:choose>
          </label>
        </div>
  
    
        <button type="submit" class="btn btn-outline-info">로그인</button>
        <button type="button" class="btn btn-outline-success"
         onclick="location.href='agree'">회원가입</button>
        <button type="button" data-bs-toggle="collapse" data-bs-target="#demo" onclick="change(1)" class="btn btn-outline-dark">아이디 찾기</button>
        <button type="button" data-bs-toggle="collapse" data-bs-target="#demo" onclick="change(2)" class="btn btn-outline-dark">패스워드 찾기</button>
  
  </form>
 
 <div id="demo" class="collapse mt-3">
<div class="row">
    <div class="col-sm-3">
      <input type="text" class="form-control" placeholder="Enter name" id="first">
    </div>
    <div class="col-sm-3">
      <input type="email" class="form-control" placeholder="Enter email" id="second">
    </div>
    <div class="col-sm-3">
      <button type="button" class="btn btn-outline-dark" onclick="find()">찾기</button>
    </div>
   
  </div>
   <div class=""></div>
</div>

</div>
</body>
</html>
