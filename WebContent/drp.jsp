<%@page import="java.sql.*,java.util.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
 <jsp:include page="library.jsp"></jsp:include>
<script>  
var request; 
function sendInfo()  
{  
var v=document.clockForm.t1.value;  
var url="dummy.jsp?val="+v;  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try{  
request.onreadystatechange=getInfo;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
  
function getInfo(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementById('amit').innerHTML=val;  
}
}
</script>  



</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
<form name="clockForm">
  
<div class="container-fluid text-center">    
  <jsp:include page="left.jsp"></jsp:include>  
    <div class="col-sm-8 text-left"> 

<input type="text" list="cust" id="t1" name="t1" autocomplete="off" placeholder="Enter item search..." autofocus onkeypress="sendInfo()" style="height:40px;"> 

<div id="amit" style="font-size:10px;width:100% "></div></input>
  
</div>
 
   <jsp:include page="rightPart.jsp"></jsp:include>
  </div>

</div>

<jsp:include page="footer.jsp"></jsp:include>

</form>

</body>
</html>
