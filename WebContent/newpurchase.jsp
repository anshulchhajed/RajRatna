<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>

<jsp:include page="library.jsp"></jsp:include>


    
  <style type="text/css">
    @media screen{
    #printdiv{
      display:none;
    }
  
    }
    
    #modaldiv{
    padding:5px;
    display:block;
}

#hideTable{

  display:block;
	overflow: auto;
	display: block;
	
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
  
 </style>
 
 
<script type="text/javascript">
var qt;
var request;
function sendInfo()  
{
	var v= document.clockForm.itemname.value;

var url="PurchaseItemData.jsp?val="+v;
  
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

document.getElementById("itemcode").value=val;  
}  
} 


function getDesignCode(){
	var val=document.getElementById("rate").value;
	val="99"+(val*2)+"99";
	document.getElementById("designcode").value=val;
}



</script>


</head>

<jsp:include page="common.jsp"></jsp:include>	

<%
ArrayList<Data> al=new ArrayList<Data>();
String companyName="";
String paytype="";

ResultSet rs5=null;
ResultSet rs4=null;
ResultSet rs6=null;
String date=null;
	java.util.Date dt = new java.util.Date();
	SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
	 date=format.format(dt);
	Database db=new Database();
	
	PreparedStatement ps4 = Data.con.prepareStatement("select * from dealers");	
	PreparedStatement ps5 = Data.con.prepareStatement("select * from purchasebook");	
	PreparedStatement ps6 = Data.con.prepareStatement("select * from item");
	rs4 = ps4.executeQuery();
	rs5 = ps5.executeQuery();
	rs6 = ps6.executeQuery();

	while (rs4.next()) {
		Data data=new Data();
		data.companyName = rs4.getString("companyname");
		al.add(data);
	}
	try{
	if(rs5.next()){
		companyName=rs5.getString("companyname");	
		paytype=rs5.getString("paymenttype");
	}
	}
	catch(Exception e){
		companyName=null;
		paytype=null;
	}
	

%>

<body>

<jsp:include page="header.jsp"></jsp:include>

<form name="clockForm" >

<div class="container-fluid text-center">    
  
  <div class="row content">
  <div class="col-sm-2" style="padding-top: 20px;background-color: #f1f1f1;height: 55%;">
           <img src=css/images/r.png height="100px" width="100px">
           <h4 style="font-family:trajan">Raj Group & Co.</h4>
      <hr style="border: 1px dashed #555;">
    </div>
 
  
    <div class="col-sm-8 text-left"> 
    
      <table  align="right" class="table table-bordered table-striped mb-0" style="width:100%">
      <tr>
      </table>

         <table  width="100%">
         <tr align="center"><td><b>Company Name:</td>
         <td><b>Purchase Type:</td></tr>
 <tr>
<td><select id="dealerSelect" class="form-control" >
<option value="Dealer" selected disabled>Select Dealer</option>
<%

for(int i=0;i<al.size();i++){
if(companyName.equals(al.get(i).companyName)){
	
%>

<option  value="<%=al.get(i).companyName %>" selected><%=al.get(i).companyName %></option>
<%
}
else{
	%>
<option  value="<%=al.get(i).companyName %>" ><%=al.get(i).companyName %></option>
<%	
}
}
%>
</select></td>

<td><select  required id="paytype" class="form-control" >
<option value="Type" selected disabled >Select Type</option>
<%
if(paytype.equals("Credit")){
	%>
	<option value="Cash" >Cash</option>
	<option  value="Credit" selected >Credit</option>	
<%
}
else if(paytype.equals("Cash")){
%>
<option value="Cash" selected>Cash</option>
<option  value="Credit" >Credit</option>
<%
}
else{
	
%>
<option value="Cash" >Cash</option>
<option value="Credit" >Credit</option>
<%
}
%>
</select></td></tr>
</table>

   <hr>
   <%
   long voc=0;
	PreparedStatement ps7 = Data.con.prepareStatement("select * from recentactivity");	
   ResultSet rs7=ps7.executeQuery();
   if(rs7.next()){
	   if(rs7.getString("voucheropenflag").equals("true")){
		  voc=rs7.getLong("tempvoucherno"); 
		  
	   }
	   else{
		   voc= rs7.getLong("voucherno");   
	   }
	   	   
   }

   
   %>
     <table  width="100%" id="custData" >
     <tr><td width="10%">VoucherNo.</td><td align="left" id="voucherno"><%=voc%></td>
        <td width="70%" align="right">Date: &nbsp;</td><td id="date" align="left" ><%=date%></td>
    </tr>
      </table>
    	
      <div id="qtydiv">
  <table id="dataTable" class="table table-bordered table-striped mb-0" width="100%" >
    <thead>
      <tr>
         <th scope="col">Item Name</th>
        <th scope="col">Code</th>
        <th scope="col">Rate</th>
        <th scope="col">Design</th>
        <th scope="col" >Color</th>
        <th scope="col">Profit</th>
        <th scope="col">Rate Diff</th>
        <th scope="col">Quantity</th>
        <th scope="col">Amount</th>
        
      </tr>
    </thead>
    <tbody align="center">
     <td><input type="text" id="itemname" onblur="sendInfo()" list="itemdata" style="width:100px" class="form-control"></td>
  	<td><input type="text" id="itemcode"  class="form-control"></td>
  	<td><input type="number"  id="rate" class="form-control" onblur="getDesignCode()"></td>
  	<td><input type="text"  id="designcode" style="width:90px" class="form-control"></td>
  	<td>  <input type="text" id="color" class="form-control" value="Mix"></td>
  	<td><input type="number"  id="profit" class="form-control"></td>
  	<td><input type="number"  id="ratediff" class="form-control" onkeypress="openModel(event)" placeholder="Enter"></td>
  	<td><input name="qty" id="qty" type="text" readonly="readonly" class="form-control" ></td>
  	<td><input type="text" id="amount" class="form-control" readonly="readonly" style="width:100px"  onkeypress="fetchData(event)"></td>
  									
      </tbody>
     </table>
     </div > 
  <datalist id="itemdata">
  <%
	while (rs6.next()) {
		Data data=new Data();
		data.itemtype = rs6.getString("ItemType");
		data.itemcode = rs6.getString("ItemCode");
		%>
		
		 <option value="<%=data.itemtype%>"><%=data.itemcode%></option>
	<%
	}
  %>
 
  
  </datalist>
     <%
     int sizeTable=9;
     %>
     
         <div id="modaldiv">
     <table id="hideTable" class="table table-bordered table-striped mb-0" width="100%">
      <tr>
        <th scope="col">Size</th>
       
       <%
       for(int i=0;i<sizeTable;i++){
    	   %>
    	    <td>
    	   <input type="text" class="form-control" style="width:65px" onkeypress="tabToRate(event)" list="mylist<%=i%>" id="sizeInput<%=i%>">
    	   <datalist  id="mylist<%=i%>">
    	   <option value="26">26</option>
    	   <option value="28">28</option>
    	   <option value="30">30</option>
    	   <option value="32">32</option>
    	   <option value="34">34</option>
    	   <option value="36">36</option>
    	   <option value="38">38</option>
    	   <option value="40">40</option>
    	   <option value="XS">XS</option>
    	   <option value="S">S</option>
    	   <option value="L">L</option>
    	   <option value="XL">XL</option>
    	   <option value="XXL">XXL</option>
    	   </datalist>
    	   </td>
    	   <%
       }
       %>
       
       
     </tr>
      <tr>
        <th scope="col">Rate</th>
        <%
       for(int i=0;i<sizeTable;i++){
    	   if(i==0){
    	   %>
    	    <td>
    	   <input type="text" class="form-control"  onkeypress="tabToQty(event)"  id="rateInput<%=i%>">
    	   </td>
    	   <%
       }
    	   else{
    		   %>
    		   <td>
        	   <input type="text" class="form-control" onkeypress="tabToQty(event)"  id="rateInput<%=i%>">
        	   </td>
        	   <% 
    	   }
       }
       %>
     </tr>
      <tr>
        <th scope="col">Qty</th>
         <%
       for(int i=0;i<sizeTable;i++){
    	   %>
    	    <td>
    	   <input type="text" class="form-control" onkeypress="revert(event)" id="qtyInput<%=i%>">
    	   </td>
    	   <%
       }
       %>
     </tr>
     </table>
  
      <script>
      
      var qt;
      var request;
      var count=<%=sizeTable%>;
      var flag=true;
      function openModel(ev){
    		
    	 var itemcode=document.getElementById("itemcode").value;
    	 var itemname=document.getElementById("itemname").value;
    	 var rate=document.getElementById("rate").value;
    	 var designcode=document.getElementById("designcode").value;
    	 var color=document.getElementById("color").value;
    	 var profit=document.getElementById("profit").value;
    	 var ratediff=document.getElementById("ratediff").value;
    	
    	if(itemcode.length==0 || itemname.length==0 || rate.length==0 || designcode.length==0 || color.length==0 || profit.length==0 || ratediff.length==0 || qty.length==0){
    		
    		if(itemcode.length==0){
    			document.getElementById("itemcode").style.border="1px solid red"
    				document.getElementById("itemcode").focus();
    		}
    		if(itemcode.length>0){
    			document.getElementById("itemcode").style.border=""
    		}
    		
    		if(itemname.length==0){
    			document.getElementById("itemname").style.border="1px solid red"
    				document.getElementById("itemname").focus();
    		}
    		if(itemname.length>0){
    			document.getElementById("itemname").style.border=""
    		}
    		
    		if(rate.length==0){
    			document.getElementById("rate").style.border="1px solid red"
    				document.getElementById("rate").focus();
    		}
    		if(rate.length>0){
    			document.getElementById("rate").style.border=""
    		}
    		
    		if(designcode.length==0){
    			document.getElementById("designcode").style.border="1px solid red"
    				document.getElementById("designcode").focus();
    		}
    		if(designcode.length>0){
    			document.getElementById("designcode").style.border=""
    		}
    		
    		if(color.length==0){
    			document.getElementById("color").style.border="1px solid red"
    				document.getElementById("color").focus();
    		}
    		if(color.length>0){
    			document.getElementById("color").style.border=""
    		}
    		
    		
    		if(profit.length==0){
    			document.getElementById("profit").style.border="1px solid red"
    				document.getElementById("profit").focus();
    		}
    		if(profit.length>0){
    			document.getElementById("profit").style.border=""
    		}
    		
    		
    		if(ratediff.length==0){
    			document.getElementById("ratediff").style.border="1px solid red"
    				document.getElementById("ratediff").focus();
    		}
    		if(ratediff.length>0){
    			document.getElementById("ratediff").style.border=""
    		}
    		
    	
    	}
    	else{
    		document.getElementById("itemcode").style.border=""
    		document.getElementById("itemname").style.border=""
    		document.getElementById("designcode").style.border=""
    		document.getElementById("rate").style.border=""
    		document.getElementById("color").style.border=""
    		document.getElementById("ratediff").style.border=""
    		document.getElementById("profit").style.border=""
    		var key= ev.keyCode;
    		if(key==13){
    		document.getElementById("modaldiv").style.display = "";
    		document.getElementById("dataTable").style.display = "none";
    		document.getElementById("purchaseData").style.display = "none";   
    		document.getElementById("sizeInput0").focus();
    		}
    		
      }
      }
     
      function tabToRate(event){
    	  var key=event.keyCode;
  		if(key==13){
  			document.getElementById("rateInput0").focus();
  			var rate=document.getElementById("rate").value;
  			var rd=document.getElementById("ratediff").value;
  			var profit=document.getElementById("profit").value;
  			 var limit=<%=sizeTable%>;
  	    	  var count=0;
  	  			for(var i=0;i<limit;i++){
  	  				if(document.getElementById("sizeInput"+i).value.length!=0){
  	  					count++;
  	  				}
  	  				}
  	  			var tot=rate*count;
  	  			var profittot=tot+((tot*profit)/100);
  	  			var centerprice=profittot/count;
  	  			var minuscenterprice=centerprice*1;
  	  			var addcenterprice=centerprice*1;
  	  		if(count%2==0){
  	  		var val=(count)/2;
  	  		
  	  		document.getElementById("rateInput"+val).value=centerprice+(rd-5);
  	  	  	document.getElementById("rateInput"+(val-1)).value=centerprice-(rd-5);
  	 		 	 minuscenterprice=centerprice-(rd-5);	
  	 		 	addcenterprice=centerprice+(rd-5);
  	  	  	for(var i=val-2;i>=0;i--){
  	  	  	minuscenterprice=minuscenterprice-10;
  	  	  			document.getElementById("rateInput"+i).value=minuscenterprice;
  	  	  			}
  	  	  			for(var j=val+1;j<count;j++){
  	  	  			addcenterprice=addcenterprice+(10*1);
  	  	  			document.getElementById("rateInput"+j).value=addcenterprice;
  		  			}	
  
  	  		
  	  		
  	  		}
  	  		else{
  	  			var val=(count-1)/2;
  	  		document.getElementById("rateInput"+val).value=centerprice;
  	  			for(var i=val-1;i>=0;i--){
  	  				 minuscenterprice=minuscenterprice-rd;
  	  			document.getElementById("rateInput"+i).value=minuscenterprice;
  	  			}
  	  			for(var j=val+1;j<count;j++){
  	  			addcenterprice=addcenterprice+(rd*1);
  	  			document.getElementById("rateInput"+j).value=addcenterprice;
	  			}
  	  		}
  			
  	  		for(var l=count;l<=limit;l++){
  	  		document.getElementById("rateInput"+l).value="";
  	  		document.getElementById("qtyInput"+l).value="";
  	  		}
      }
  		
      }
      
      function tabToQty(event){
    	  var key=event.keyCode;

  		if(key==13){
  			document.getElementById("qtyInput0").focus();
      }
      }

      function getRate(){
    	  if(document.getElementById("rateInput0").value.length!=0){
    	  var rd=document.getElementById("ratediff").value;
    	  var limit=<%=sizeTable%>;
    	  var count=0;
  			for(var i=0;i<limit;i++){
  				if(document.getElementById("sizeInput"+i).value.length!=0){
  					count++;
  				}
  			}
  			for(var k=1;k<count;k++){
  				var rt=document.getElementById("rateInput"+(k-1)).value;
  				document.getElementById("rateInput"+k).value=(rt*1)+(rd*1);
  			}
      }
      }
  
  		function revert(event){
    		var key=event.keyCode;
    		if(key==13){
    		document.getElementById("modaldiv").style.display = "none";
    		document.getElementById("dataTable").style.display = "";
    		document.getElementById("purchaseData").style.display = "";
    		var rate=document.getElementById("rate").value;
    		var qty=document.getElementById("qty").value;
    		var profit=document.getElementById("profit").value;	
    		document.getElementById("amount").focus();
    		document.getElementById("amount").value=totprice;
      
      	  if(document.getElementById("rateInput0").value.length!=0){
      		  var sum=0;
          	  var count=0;
          	  var qty=0;
      		  var limit=<%=sizeTable%>;
      	 
    			for(var i=0;i<limit;i++){
    				if(document.getElementById("sizeInput"+i).value.length!=0){
    					count++;
    				}
    			}
    			for(var k=0;k<count;k++){
    				var rt=document.getElementById("rateInput"+k).value;
    				 var qt=document.getElementById("qtyInput"+k).value;
    				 sum=sum+(rt*1)*(qt*1)
    				 qty=qty+(qt*1);
    			}
    			var totprice=rate*qty;
    			document.getElementById("amount").value=totprice;  
    			document.getElementById("qty").value=qty;
      	  }
      	  else{
      		document.getElementById("amount").value=0;
			document.getElementById("qty").value=0;
      	  }
        
     }
  }
 
     </script> 

    </div>
 
<script type="text/javascript">

document.getElementById("modaldiv").style.display = "none";

var request;
function fetchData(ev){
	var dv = document.getElementById("dealerSelect");
	var dealerV = dv.options[dv.selectedIndex].value;
	var dl = document.getElementById("paytype");
	var payT = dl.options[dl.selectedIndex].value;
	var count=0;
	 var limit=<%=sizeTable%>;
	 var flag=false;
	for(var m=0;m<limit;m++){
		if(document.getElementById("sizeInput"+m).value.length!=0){
			count++;
		}
	}
	for(var i=0;i<count;i++){
	 var newval=document.getElementById("rateInput"+i).value
	 var newval1=document.getElementById("qtyInput"+i).value
	 if(newval.length==0 || newval1.length==0){
		flag=true;
	 	break;
	 }
	}
	 if(dealerV=="Dealer" || payT=="Type"){
		
		 if(dealerV=="Dealer"){
		 document.getElementById("dealerSelect").style.border="1px solid red"
		document.getElementById("dealerSelect").focus();
		 }
		 if(dealerV!="Dealer"){
			 document.getElementById("dealerSelect").style.border=""
			}
		 
		 if(payT=="Type"){
			 document.getElementById("paytype").style.border="1px solid red"
			document.getElementById("paytype").focus();
			 }
			 if(payT!="Type"){
				 document.getElementById("paytype").style.border=""
				 }
	 }
	 else if(flag || count==0){
		 document.getElementById("paytype").style.border=""
			 document.getElementById("dealerSelect").style.border=""
		 		document.getElementById("qty").style.border="1px solid red"
				alert("Enter Product Size and Qty");
				document.getElementById("qty").focus();
				
	
	 }
	
	 else{
	var key= ev.keyCode;
	if(key==13){
		
	var a=document.getElementById("itemcode").value;
	var b=document.getElementById("itemname").value;
	var c=document.getElementById("rate").value;
	var d=document.getElementById("designcode").value;
	var e=document.getElementById("color").value;
	var f=document.getElementById("profit").value;
	var g=document.getElementById("ratediff").value;
	var h=document.getElementById("qty").value;
	var i=document.getElementById("amount").value;
	var k = document.getElementById("dealerSelect");
	var dealerval = k.options[k.selectedIndex].value;
	var l = document.getElementById("paytype");
	var paytype = l.options[l.selectedIndex].value;
	var voucherno = document.getElementById("voucherno").innerHTML;
	var date = document.getElementById("date").innerHTML;
	document.getElementById("dealerSelect").disabled=true;
	 document.getElementById("paytype").disabled=true;
	  var count=0;
	  var limit=<%=sizeTable%>;
	  var newsize="";
	  var newrate="";
	  var newqty="";
		for(var m=0;m<limit;m++){
			if(document.getElementById("sizeInput"+m).value.length!=0){
				count++;
			}
		}
	 for(var j=0;j<count;j++){
		var size=document.getElementById("sizeInput"+j).value;
		var rate=document.getElementById("rateInput"+j).value;
		var qty=document.getElementById("qtyInput"+j).value;
		
		if(j==count-1){
			newsize=newsize+size;
			newrate=newrate+rate;
			newqty=newqty+qty;
		}
		else{
			newsize=newsize+size+",";
			newrate=newrate+rate+",";
			newqty=newqty+qty+",";
		}
	
	 }
	
	
	var url="PurchaseBookData.jsp?val1="+a+"&val2="+b+"&val3="+c+"&val4="+d+"&val5="+e+"&val6="+f+"&val7="+g+"&val8="+h+"&val9="+i+"&val10="+dealerval+"&val11="+paytype+"&val12="+voucherno+"&val13="+date+"&val14="+newsize+"&val15="+newrate+"&val16="+newqty;	  
	if(window.XMLHttpRequest){  
	request=new XMLHttpRequest();  
	}  
	else if(window.ActiveXObject){  
	request=new ActiveXObject("Microsoft.XMLHTTP");  
	}  
	  
	try{  
	request.onreadystatechange=getPurchase; 
	request.open("GET",url,true);  
	request.send();
	
	}catch(e){alert("Unable to connect to server");}  
	
	}
	
}
	 
	 
}
	function getPurchase(){  
	if(request.readyState==4){  
		location.reload();
	}  
	}  
	
</script>
	
   </div>
  
  <div class="col-sm-2" style="padding-top:20px;background-color: #f1f1f1;height: 55%;">
<% 

String billcount=(String)request.getAttribute("billcount");

db.getTotalSale();
%>
      <div class="well">
        <p>Total Sale: &#8377;<%=db.getTotalSale() %>/-</p>
        <button type="button" class="btn btn-primary">
  		Total Bill <span class="badge badge-light"><%=billcount%></span>
		</button>
      </div>
      <div class="well">
        <p>View Last Bill</p>
      </div>
    </div>
    </form>
   
     <div id="purchaseData" class="col-sm-12">
      <jsp:include page="GetPurchaseData.jsp"></jsp:include>						 
      </div>
  </div>
  
</div>
<jsp:include page="footer.jsp"></jsp:include>


 <jsp:include page="PurchaseItemData.jsp"></jsp:include>
 
 


</div>


</body>

</html>
