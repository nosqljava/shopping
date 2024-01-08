<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="util" uri="/ELFunctions" %>
 
<!DOCTYPE html> 
<html> 
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
   <script type="text/javascript">
   	 $(function(){
   		document.querySelector('#icon').style.display ='none';
		document.querySelectorAll("#ch").forEach((item) => { 
			item.addEventListener("change",function(){						
				totalPrice();
			});
		});
   		 
   	 });
   	 
   	 function totalPrice(){
   		 let tot = 0;
   		 
   		 let ch = document.querySelectorAll("#ch:checked");
   		 ch.forEach((item)=>{
   			let val = item.value;
   			
   			let price = document.querySelector("#price-"+val).innerText;
   			let qty = document.querySelector("#qty-"+val).value;
   			
   			tot += price * qty;
   			
   		 });
   		 if(tot > 0){
   		 	document.querySelector("#tot").innerText="주문금액 "+tot+"원 + 배송비 3,000원 = 합계 "+(tot + 3000);
   		 	document.querySelector('#icon').style.display='';
   		 }else{
   			document.querySelector("#tot").innerText="";
   			document.querySelector('#icon').style.display ='none';
   		 }
   	 }
   
     function del(cartno){
    	 if(confirm('상품을 삭제하겠습니까?')){
    		 let url = '/cart/delete/'+cartno;
    		 location.href = url;
    	 }
     }
   
     function read(contentsno){
       alert(contentsno);
       var url = "/contents/detail/"+contentsno;
       location.href=url;
 
     }
     
     function checkAll(check){
         if(check.checked){
        	let aa = document.querySelectorAll("#ch");
        	aa.forEach((item)=>item.checked=true);
        	totalPrice();
         }else{
        	let aa = document.querySelectorAll("#ch")
        	aa.forEach((item)=>item.checked=false);
        	document.querySelector("#tot").innerText="";
        	document.querySelector('#icon').style.display ='none';
         }
        }
  
     function order(){
    	 let cno = document.querySelectorAll("#ch");
    	 let qty = document.querySelectorAll("[id^=qty]");
    	 let size = document.querySelectorAll("#size");
    	 
    	 let cnt = 0; //체크값을 검사하는 변수
    	 let param_cno = ''; //상품번호가 여러개 연결된다.
    	 let param_qty = ''; //수량을 여러개 연결한다.
    	 let param_size = ''; //사이즈를 여러개 연결한다.
    	 
    	 for(let i=0; i<cno.length; i++){
    		 if(cno[i].checked==true){
    			 cnt++;
    			 param_cno += cno[i].value +',';
    			 param_qty += qty[i].value +',';
    			 param_size += size[i].innerText +',';
    		 }
    	 }
    	 
    	 if(cnt==0){
    		 alert("상품을 선택하세요");
    		 return;
    	 }else{
    		 //alert(param_cno);
    		 //alert(param_qty);
    		// alert(param_size);
    		 
    		 let url = "/order/create/cart/"+param_cno+"/"+param_qty+"/"+param_size;
    		 location.href=url;
    	 }   	 
    	 
     }
  </script>
 
</head>
<body>
<div class="container mt-3">
 
  <h3><i class="bi bi-cart4 fs-4"></i> 장바구니</h3>
 
  <table class="table table-striped">
   <thead>
    <tr>
    <th><input type='checkbox' id="checkall" onchange="checkAll(this)"></th>
    <th>상품이미지</th>
    <th>상품명</th>
    <th>수량</th>
    <th>가격</th>
    <th>삭제</th>
    </tr>
   </thead>
   <tbody>
 
<c:choose>   
<c:when test="${empty list}">
   <tr><td colspan="6">등록된 상품이 없습니다.</td>
</c:when>
<c:otherwise>
  
   <c:forEach var="dto" items="${list }"> 
   <tr>
    <td><input type='checkbox' id='ch' value="${dto.cdto.contentsno }" ></td>
    <td>
    <img src="/contents/storage/${dto.cdto.filename }"  class="img-rounded" width="100px" height="100px">
    </td>
    <td>
    <a href="javascript:read('${dto.cdto.contentsno}')">${dto.cdto.pname}(size :<span id='size'>${dto.size}</span>)</a>
    
    </td>
    <td><input type='number' value="${dto.count}" min="1" max="10" id="qty-${dto.cdto.contentsno }"></td>
    <td><span id='price-${dto.cdto.contentsno }'>${dto.cdto.price}</span></td>
    <td> 
        <a href="javascript:del('${dto.cartno }')">
          <i class="bi bi-trash fs-5"></i>
        </a>     
    </td>
   </tr>
   </c:forEach>
   </c:otherwise>
   </c:choose>
   </tbody>
   <tfoot>
   <tr style="background-color:beige;font-size:large">
   <th colspan="6" style="padding:30px;">
    <span id='tot'></span>
    <span id='icon'>
    <a href="javascript:order()">
   	<i class="bi bi-bag-heart-fill fs-5" title='주문하기'></i></a>
   	<a href="/contents/mainlist/1">
   	<i class="bi bi-box2-heart fs-5" title="쇼핑계속"></i></a>
   	</span>
   </th>
   </tr>

   </tfoot>
  </table>

</div>
</body> 
</html> 
