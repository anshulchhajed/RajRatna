<%@ page import="java.sql.*"%>  
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
  
<!DOCTYPE html> 
<html> 

<head> 
<script type="text/javascript">

var qt;
var request;
function sendInfo()  
{
	
var url="DummyData.jsp";
  
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
	var json =JSON.parse(request.responseText);
	alert(json.data1[6]);
}  
} 

</script>
 </head>
 <body>
 <form >
	<button type="button" onclick="sendInfo()">Click</button>
 
 </form>
</body> 

</html> 
