<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
setTimeout(function() {
    $('#dismissAlert,#dismissAlert1').fadeOut('fast');
}, 1000);
</script>
<jsp:include page="library.jsp"></jsp:include>

<style type="text/css">
.my-custom-scrollbar {
position: relative;
height: 200px;
overflow: auto;
}

.table-wrapper-scroll-y {
	display: block;
}
</style>
</head>

<jsp:include page="common.jsp"></jsp:include>

<body>

	<jsp:include page="header.jsp"></jsp:include>

	<form name="clockForm" action="AddItemServlet" method="post">

		<div class="container-fluid text-center">
			<jsp:include page="left.jsp"></jsp:include>

  			<div  class="col-sm-8 text-left">
			<center><h2>Item Setup</h2>
		<p class="hint-text">Add Update Or Delete Item</p>
    </center>  
  <div class="col-sm-4" style="padding:5px;">
<%
Database db=new Database();
ArrayList<Data> al=db.getItem();
%>
    <div class="table-wrapper-scroll-y my-custom-scrollbar" >
    <ul id="sel">
      <li class="form-control btn-primary" align="center" style="height:40px; font-size:25px; padding:2px" >Item List</li>
  	  <%
  	  for(int i=0;i<al.size();i++)
  	  {
  	
  		 %>
  		 
  		  <li   class=" form-control btn-info" align="center" id="opt" style="margin-top:2px;width:100%;height:30px" value="<%=al.get(i).itemcode%>" onclick="selectClick()"><%=al.get(i).itemtype %></li>
      <%
  	  }
      %>
      </ul>
    </div>
    <br><br>
   
  </div>
   			
   		
   		  <div class="form-group">
			
				<div class="col-sm-8" style="padding:5px">
				<input type="text" class="form-control" id="item_name" name="item_name" placeholder="Item Name" required="required"></input>
				</div>
				
					<div class="col-sm-8" style="padding:5px">
				<input type="text" class="form-control" id="item_code" name="item_code" placeholder="Item Code" required="required"></input>
			</div>
			<div class="col-sm-2" style="padding:10px">
       		    <button type="submit" class="btn btn-primary btn-lg btn-block" name="submit" value="add">Add Item</button>
       		    </div>
       		<div class="col-sm-3" style="padding:10px">	    
          		<button type="submit" class="btn btn-primary btn-lg btn-block" name="submit" value="update">Change Item</button>
          		</div>
          			<div class="col-sm-3" style="padding:10px">
          		<button type="submit" class="btn btn-danger btn-lg btn-block" name="submit" value="delete">Delete Item</button>
            </div>
          
         <center><div class="col-sm-8"><p>
          	 <%
					String success = (String) request.getAttribute("success");
					if (success != null) {
				%>
				<div id="dismissAlert" onmouseover="hideme()" class="alert alert-success alert-dismissible">
				<button type="button" class="close" data-dismiss="alert" >&times;</button>
 					<center><strong><%=success%></strong></center>
				</div>
				<%
					}

					String failed = (String) request.getAttribute("failed");
					if (failed != null) {
				%>
				<div id="dismissAlert1" onmouseover="hideme()" class="alert alert-danger alert-dismissible">
				<button type="button" class="close" data-dismiss="alert" >&times;</button>
 					<center><strong><%=failed%></strong></center>
				</div>
				<%
					}
				%>
           
           
           </p></div></center>  
        </div>		
		</div>		
			
			<jsp:include page="rightPart.jsp"></jsp:include>
		</div>

		<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript">

function selectClick(){
    var items = document.querySelectorAll("#opt");
    
    for(var i = 0; i < items.length; i++)
    {
        items[i].ondblclick = function(){
            
            document.getElementById("item_name").value = this.innerHTML;
            document.getElementById("item_code").value = this.value;
            
        };
    }
}

</script>
	</form>
</body>
</html>
