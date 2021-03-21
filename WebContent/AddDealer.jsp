<%@page import="java.util.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
setTimeout(function() {
    $('#dismissAlert,#dismissAlert1').fadeOut('fast');
}, 1000);
</script>
   <jsp:include page="library.jsp"></jsp:include>
</head>
 <jsp:include page="common.jsp"></jsp:include>
<body>
 <jsp:include page="header.jsp"></jsp:include>
<form name="clockForm" action="AddDealerServlet" method="post">
<div class="container-fluid text-center">    
  <jsp:include page="left.jsp"></jsp:include>
  
    <div class="col-sm-8 text-left"> 
   <center><h2>Add Merchant</h2>
		<p class="hint-text">Register the Company or Dealer</p>
    </center>
    
     <div class="col-sm-4 justify-left" style="padding:5px; ">
<%
Database db=new Database();
ArrayList<Data> al=db.getDealerList();
%>
    <div style="width:100%;" class="table-wrapper-scroll-y my-custom-scrollbar" >
    <ul id="sel" >
      <li  class="form-control btn-primary" align="center" style="  ;height:40px; font-size:25px; padding:2px" >Dealer List</li>
  	  <%
  	  for(int i=0;i<al.size();i++)
  	  {
  	
  		String temp=al.get(i).companyName.replaceAll("\\s",""); 
  		
  		 %>
  		 
  		  <li class=" form-control btn-info" align="center" id="opt" value="<%=temp%>" style="margin-top:2px;width:100%;height:30px" onclick="selectClick()"><%=al.get(i).companyName%></li>
   		  <input type="hidden" id="<%=temp%>" value="<%=al.get(i).companyName %>" />
   		  <input type="hidden" id="<%=temp%>" value="<%=al.get(i).contact %>" />
   		  <input type="hidden" id="<%=temp%>" value="<%=al.get(i).address %>" />
   		  <input type="hidden" id="<%=temp%>" value="<%=al.get(i).accountNo %>" />
   		  <input type="hidden" id="<%=temp%>" value="<%=al.get(i).bankName %>" />
   		  <input type="hidden" id="<%=temp%>" value="<%=al.get(i).ifcsCode %>" />
   		 
      <%
    
  	  }
      %>
      </ul>
    </div>
  
   
  </div>
   			 
          <div class="form-group">
			
			<div style="padding:1px" class="col-sm-4"><input type="text" class="form-control" id="company_name" name="company_name" placeholder="Company Name" required="required"></input></div>	
       	
			<div style="padding:1px" class="col-sm-4"><input type="text" class="form-control" id="contact" name="contact" placeholder="Contact" required="required"></input></div>	
       	
			<div style="padding:1px"  class="col-sm-4"><input type="text" class="form-control" id="address" name="address" placeholder="Address" required="required"></input></div>	
       	
			<div style="padding:1px"  class="col-sm-4"><input type="text" class="form-control" id="account_no" name="account_no" placeholder="Account No." required="required"></input></div>	
       	
			<div style="padding:1px"  class="col-sm-4"><input type="text" class="form-control" id="bank_name" name="bank_name" placeholder="Bank Name" required="required"></input></div>	
       	
			<div style="padding:1px" class="col-sm-4"><input type="text" class="form-control" id="ifsc" name="ifsc" placeholder="IFSC Code" required="required"></input></div>	
        </div>
            	<div class="form-group">
          <div style="padding:1px" class="col-sm-2"><button type="submit" name="submit" value="add" class="btn btn-primary btn-lg btn-block">Add Dealer</button></div>
		  <div style="padding:1px"  class="col-sm-3"><button type="submit" name="submit" value="update" class="btn btn-primary btn-lg btn-block">Update Dealer</button></div>
		  <div style="padding:1px" class="col-sm-3"><button type="submit" name="submit" value="delete" class="btn btn-danger btn-lg btn-block">Delete Dealer</button></div>

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
</div>
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript">

function selectClick(){
    var items = document.querySelectorAll("#opt");
   
    for(var i = 0; i < items.length; i++)
    {
        items[i].ondblclick = function(){
        	
        	var z= this.innerHTML;
      	 	var v=z.split(' ').join('');
        	var x=document.querySelectorAll('#'+v);
        	
            document.getElementById("company_name").value = x[0].value;		
            document.getElementById("contact").value = x[1].value;
            document.getElementById("address").value = x[2].value;
            document.getElementById("account_no").value = x[3].value;
            document.getElementById("bank_name").value = x[4].value;
            document.getElementById("ifsc").value = x[5].value;
            
        };
    }
}

</script>
</form>

</body>
</html>
