<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="library.jsp"></jsp:include>
 <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>    
  <style type="text/css">
    @media screen{
    #printdiv{
      display:none;
    }
  
    }
    
    </style> 

 <script type="text/javascript">

var request;  
function sendInfo()  
{  

var v1=document.clockForm.custname.value;
var v2=document.clockForm.mobile.value;  
var v3=document.clockForm.billno.value;  

var url="saveData.jsp?val1="+v1+"&val2="+v2+"&val3="+v3;
  
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
document.getElementById('cust').innerHTML=val;  
}  
}  

function validateBar(){
	
	var z=document.getElementById('itemcodebarcode').value;
	if(z.length<1){
alert("invalid");
		return false;
	}
}
</script>  
<script type="text/javascript">

	document.getElementById("printdiv").style.display="none";


</script>


</head>

<jsp:include page="common.jsp"></jsp:include>	


<%
	Database db=new Database();
	PreparedStatement ps=null;
	ps= Data.con.prepareStatement("select * from tempstock");
	ResultSet rs = ps.executeQuery();	
	long billno = 0;
	long openbillno = 0;
	String custName = "";
	String name=" ";
	long mob=0l;
	long mobileno = 0;
	int discount = 10;
	int adjustamount = 0;
	int sno = 0;
	int totprice = 0;
	int disprice = 0;
	int amttopay = 0;
	boolean present = false;
	boolean existFlag=false;
	String openflag=null;
	java.sql.Date date=null;
	
	 ps = Data.con.prepareStatement("select * from recentactivity");
	ResultSet rs1 = ps.executeQuery();
	if (rs1.next()) {
		billno = rs1.getLong("lastbillno");
		openbillno = rs1.getLong("tempbillno");
		openflag = rs1.getString("openflag");
		date = rs1.getDate("Date");
		name = rs1.getString("customername");
		mob= rs1.getLong("customermobile");
	} else {
		try {
			java.util.Date dt = new java.util.Date();
			SimpleDateFormat format = new SimpleDateFormat("ddMMyyhhmmss");
			billno = Long.parseLong(format.format(dt));
			PreparedStatement ps3 = Data.con.prepareStatement("insert into recentactivity (lastbillno) values(" + billno + ")");
			ps3.executeUpdate();
		} catch (Exception e) {

		}
	}
	if(openflag.equals("true")){
		billno=openbillno;
	}
	 ps = Data.con.prepareStatement("select * from purchasebilldetail where billno=?");
	ps.setLong(1, billno);
	
	ResultSet rs2 = ps.executeQuery();
	if (rs2.next()) {
		discount = rs2.getInt("discount");
		disprice = rs2.getInt("discountamount");
		adjustamount = rs2.getInt("adjustamount");
		amttopay = rs2.getInt("amountpaid");
	}

%>

<body> 

 
<jsp:include page="header.jsp"></jsp:include>
 
<form name="clockForm" action="BillingServlet" method="post">

<div class="container-fluid text-center">    
  <jsp:include page="left.jsp"></jsp:include>
  
    <div class="col-sm-8 text-left"> 
 
      <hr>
    
      <table  align="right" class="table table-bordered table-striped mb-0" style="width:100%">
      <tr>
      </table>
    <hr>
 
         <table width="100%">
            <tr>
<td><input type="text" name="itemcodebarcode"  id="itemcodebarcode" class="form-control" autofocus style="font-size:20px;height:40px; width:100%;"></input></td>
<td><input type="submit" class="btn btn-primary" name="search" id="search" value="Search" onclick="return check()" style=" width:100%;font-size:20px;height:40px;"></input></td></tr>
</table>
  
   <hr>
   
     <table width="100%" id="custData" >
     <tr><td id="bill"><b>Bill No.<%=billno %></td>
        <td align="center"><b>Name: <%=name %></td>
        <td align="right"><b>Mobile No: <%=mob %></td></tr>
      </table>
      <span id="cust"> </span>
    <div style="height:50px">
       <%
       			
					String msg = (String) request.getAttribute("msg");
					if(msg!=null){
				%>
				<div id="dismissAlert" class="alert alert-danger alert-dismissible">
				<button type="button" class="close" data-dismiss="alert" >&times;</button>
 					<center><strong><%=msg%></strong></center>
				</div>
				<%
				}
					String failed = (String) request.getAttribute("failed");
					if(failed!=null){
				%>
				<div  id="dismissAlert1" class="alert alert-success alert-dismissible">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
 					<center><strong><%=failed%></strong></center>
				</div>
				<%
				}
				
					String success = (String) request.getAttribute("success");
					if(success!=null){
				%>
				<div id="dismissAlert2" class="alert alert-success alert-dismissible">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
 					<center><strong><%=success%></strong></center>
				</div>
				<%
				}
					String billMsg = (String) request.getAttribute("billMsg");
					if(billMsg!=null){
						%>
						<div id="dismissAlert3" class="alert alert-danger alert-dismissible">
						<button type="button" class="close" data-dismiss="alert" >&times;</button>
		 					<center><strong><%=billMsg%></strong></center>
						</div>
						<%
						}
						%>
				</div>
			
      <div class="table-wrapper-scroll-y my-custom-scrollbar">
  <table id="dataTable" class="table table-bordered table-striped mb-0" width="100%">
    <thead>
      <tr>
       
        <th scope="col">Item Code</th>
        <th scope="col">Item Name</th>
        <th scope="col">Size</th>
        <th scope="col" >Quantity</th>
        <th scope="col">Price</th>
        <th scope="col">Action</th>
        
      </tr>
    </thead>
    <tbody align="center">
    <%
   int rowcount=0;
    int itemcount=0;
 
 ArrayList<Data>al=db.getCustomerPurchase(billno);
if(al.size()>0){
	existFlag=true;
}
 while(rs.next())
{	
	if( rs.getInt("currQuantity")!=0){
	 Data obj1=new Data();
	 sno=sno+1;
	present=true;
obj1.itemcode=rs.getString("itemcode");
obj1.itemtype=rs.getString("itemtype");
obj1.size=rs.getInt("size");
obj1.currPrice=rs.getInt("currPrice");
obj1.currQuantity=rs.getInt("currQuantity");
obj1.quantity=rs.getInt("quantity");
totprice+=obj1.currPrice;
itemcount=itemcount+obj1.currQuantity;
%>     
      <tr align="center">
        <td ><b><%=obj1.itemcode%></th>
        <td><%=obj1.itemtype%></td>
        <td><%=obj1.size%></td>
        <td><button type="submit" name="minus" value="<%=obj1.itemcode%>" >-</button>&nbsp;<input type="text" size="1" style="width:25px" id="qt<%=sno %>" readonly="readonly" name="quantity" value="<%=obj1.currQuantity%>" onblur="sendInfo()"></input>&nbsp;<button type="submit" name="add" value="<%=obj1.itemcode%>" >+</button></td> 
    	  <td><%=obj1.currPrice%></td>
        <td><button type="button" id="<%=obj1.itemcode%>"><img src="css/images/delete.png" height="20px" width="20px" /></button></td>
        </tr>
        <%
     
        if(obj1.currQuantity>=obj1.quantity)
        {
        %>	
        	 <script>
        	 document.getElementById("qt<%=sno %>").style.borderColor = "red";
        	 </script>
        <%
        }
rowcount++;
}
}
if(rowcount<=0)
{
	%>
  <tr  align="center" border="0" style="background-color:white;width:100%;height:120px">
    <td colspan="6" style="padding-top:40px"><b>No Items</td>
   </tr>
 	<% 
}

amttopay=0;
disprice=(totprice*discount)/100;
amttopay=(totprice-disprice)-adjustamount;

  %>   
      </tbody>
     </table>
     </div > 
     
     <table class="table table-bordered table-striped mb-0">
     
      <tr align="center">
      <td scope="col"><b>Total Item</td>
      <td scope="col"><b>Total Price</td>
      <td scope="col"><b>Discount</td>
      <td scope="col"><b>Dis. Amount</td>
      <td scope="col"><b>Adjust Amount</td>
      <td  scope="col"><b>Amount Payable</td>
   
       <tr align="center">
        <td ><b><%=itemcount%> Items</td>
        <td id="totprice"><b>&#8377; <%=totprice%>/-</td>
        <td ><input type="text" id="discount" name="discount" value=<%=discount %> style="width:30px" onblur="updateInfo()"/> %</td>
        <td id="disprice"><b>&#8377; <%=disprice%>/-</b></td>
        <td >&#8377;<input type="text" style="width:50px;" id="adjust" name="adjustamount" value="<%=adjustamount%>" onblur="updateAmt()"/></td>
        <td id="amtpay"><b>&#8377; <%=amttopay %>/-</td>     
      </tr>
      <tr>
       <td ><input type="submit" class="btn btn-primary" onclick="disable()" id="new" name="submit" value="New" style=" width:100%;font-size:15px;height:30px;" /></td>
       <td ><button type="button" class="btn btn-primary " data-toggle="modal" data-target="#myModal"  id="open" value="Open" style=" width:100%;font-size:15px;height:30px;">Open</button></td>
      <td ><input type="submit" class="btn btn-primary" onclick="disable()" id="delete" name="submit" value="Delete" style=" width:100%;font-size:15px;height:30px;" /></td>
      
      <td ><input type="submit" class="btn btn-primary" id="save" name="submit" value="Save" onclick="validateField()" style=" width:100%;font-size:15px;height:30px;" /></td>
      <td  ><input type="submit" onclick="printDiv()" class="btn btn-primary" name="submit" id="print" value="Print Bill" style=" width:100%;font-size:15px;height:30px;" /></td>
      <td ><input type="submit" class="btn btn-danger" id="clear" name="submit" value="Clear"  onclick="clear()" style=" width:100%;font-size:15px;height:30px;" /></td>
  
      </tr>
      </table>
     <input type="hidden" name="billno" value="<%=billno%>">
      <input type="hidden" name="itempurchased" value="<%=itemcount%>">
      <input type="hidden" name="totalprice" value="<%=totprice%>">
      <input type="hidden" name="discountamount" value="<%=disprice%>">
      <input type="hidden" id="amountpaid" name="amountpaid" value="<%=amttopay%>">
      <%
      if(!present && !existFlag){
	%>
<script type="text/javascript">


document.getElementById("print").disabled=true;
document.getElementById("save").disabled=true;
document.getElementById("search").disabled=true;
document.getElementById("itemcodebarcode").disabled=true;
document.getElementById("clear").disabled=true;	
document.getElementById("custData").style.visibility = "hidden";
document.getElementById("open").disabled=false;
document.getElementById("delete").disabled=true;
</script>	

	<%
	
}

       if(existFlag){
	%>
	<script type="text/javascript">
	document.getElementById("print").disabled=false;
		document.getElementById("new").disabled=true;
		document.getElementById("clear").disabled=false;
		document.getElementById("save").disabled=true;
		
	</script>
<%
}
       
       
       if(!present && existFlag){
	%>
	<script type="text/javascript">
	document.getElementById("print").disabled=true;
		document.getElementById("new").disabled=true;
		document.getElementById("clear").disabled=false;
		document.getElementById("save").disabled=true;
		document.getElementById("open").disabled=true;
		document.getElementById("delete").disabled=true;
		
	</script>
<%
}
       if(billMsg!=null){
    	   %>
    	  <script>
    	  setTimeout(function() {
    		    $('#dismissAlert3').fadeOut('fast');
    		}, 1000);
    	  </script> 
    	   
    	   <%
    	   
       }
if(msg!=null || failed!=null || success!=null){
%>
<script type="text/javascript">

//document.getElementById("dismissAlert").display="none";
document.getElementById("open").disabled=true;
	document.getElementById("delete").disabled=true;
document.getElementById("new").disabled=true;
	document.getElementById("itemcodebarcode").disabled=false;
	document.getElementById("itemcodebarcode").focus();
	document.getElementById("search").disabled=false;
	document.getElementById("clear").disabled=false;
	document.getElementById("custData").style.visibility = "visible";
	setTimeout(function() {
	    $('#dismissAlert,#dismissAlert1,#dismissAlert2').fadeOut('fast');
	}, 1000);
</script>

<%
}
      if(present){
    	  %>
    	  <script>
    	  
     	 document.getElementById("new").disabled=true;
     	document.getElementById("save").disabled=false;
     	document.getElementById("open").disabled=true;
		document.getElementById("delete").disabled=true;
     	
      <%
      }
  	if(present && success==null){
  		%>
  		document.getElementById("print").disabled=true;		
  <%
  	}
  	%>
  	 </script>
   </div>
   <jsp:include page="rightPart.jsp"></jsp:include>
  </div>
</div>
<jsp:include page="footer.jsp"></jsp:include>

<Script type="text/javascript">

function clear(){
	
	document.getElementById("new").disabled=false;
	document.getElementById("itemcodebarcode").disabled=true;
	document.getElementById("search").disabled=true;
	document.getElementById("clear").disabled=true;
	document.getElementById("custData").style.visibility = "hidden";
	
}

function disable(){
	
	document.getElementById("open").disabled=true;
	document.getElementById("delete").disabled=true;
	document.getElementById("new").disabled=true;
	document.getElementById("itemcodebarcode").disabled=false;
	document.getElementById("itemcodebarcode").focus();
	document.getElementById("search").disabled=false;
	document.getElementById("clear").disabled=false;
	document.getElementById("custData").style.visibility = "visible";
	document.getElementById("dismissAlert").style.display = "none";
	
}


function check(){

	var val=document.getElementById("itemcodebarcode").value;
	if(val==""){
		alert("required");
		return false;
	}
}


function validateField(){

	document.getElementById("dataTable").disabled=true;
	
	
}

        
function updateInfo(){
var str=(document.getElementById('totprice').innerHTML).substring(5).replace("/-","");
var check=parseInt(document.getElementById('discount').value,10);

var query = document.getElementById('discount').value;
var isNumeric=query.match(/^\d+$/);
 if(isNumeric)
 {
	 if(query.length>2){
		 query=query.substring(1);
		 document.getElementById('discount').value=query;
	 }
	 document.getElementById('discount').style.border = '1px solid';
	 
 }
 else{
	 document.getElementById('discount').value='0';
	 document.getElementById('discount').style.border = '3px solid red';
	 document.getElementById('discount').focus();
 }

if(check.length==0){
	document.getElementById('discount').value='0';
}


var x=parseInt(document.getElementById('discount').value,10);
var y=parseInt(str,10);
var val=(x*y)/100;
document.getElementById('disprice').innerHTML ="<b>&#8377; "+val+"/-";
document.getElementById('amtpay').innerHTML="<b>&#8377; "+(y-val)+"/-";
}

function updateAmt(){
	
	var query = document.getElementById('adjust').value;
	var isNumeric=query.match(/^\d+$/);
	var x;
	var y;
	var z;
	var val;
	 if(isNumeric)
	 {
		 document.getElementById('adjust').style.borderColor='';
		 var x=parseInt(document.getElementById('adjust').value);
			var y=parseInt((document.getElementById('totprice').innerHTML).substring(5).replace("/-",""));
			var z=parseInt((document.getElementById('disprice').innerHTML).substring(5).replace("/-",""));
			var val=(y-z)-x;
			document.getElementById('amountpaid').value=val;
			document.getElementById('amtpay').innerHTML="<b>&#8377; "+val+"/-";
	 }
	 else if(Math.sign(query)<0){
		 document.getElementById('adjust').style.borderColor='';
		 	x=parseInt(document.getElementById('adjust').value);
			 y=parseInt((document.getElementById('totprice').innerHTML).substring(5).replace("/-",""));
			z=parseInt((document.getElementById('disprice').innerHTML).substring(5).replace("/-",""));
			
			
			
	 }
	 else{
		 document.getElementById('adjust').value='0';
		 document.getElementById('adjust').style.borderColor="red";
		 document.getElementById('adjust').focus();
	 }
	
	}

  </script>
 
</div>
 <!-- The Modal -->
 
 <div class="modal" tabindex="-1" id="myModal" style="padding-top:100px" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">Enter Bill No.</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <input type="text" list="custdata" id="billInput" name="billInput" class="form-control" autocomplete="off" onkeypress="checkCustData()">
        <div id="amit" style="font-size:10px;width:100% "></div>
       </input>
       
        </div>
      <div class="modal-footer">
        <input type="submit" value="Open" name="submit" class="btn btn-warning"></input>
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
    <script>


$('#myModal').on('shown.bs.modal', function () {
    $('#billInput').focus();
})

var request; 
function checkCustData()  
{  
var bill=document.clockForm.billInput.value; 
var url="OpenBillData.jsp?val="+bill;  

if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try{  
request.onreadystatechange=custDataInfo;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
  
function custDataInfo(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementById('amit').innerHTML=val;  
}
}
</script>  
  
</form>
<div id="printdiv">
<jsp:include page="Bill.jsp"></jsp:include>
<%
Data.con.close();
%>
</div>
</body>
</html>
