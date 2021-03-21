<%@page import="com.Database"%>
<%@page import="java.sql.*"%>
<%@page import="com.Data"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%
long totalamt=0;
ArrayList<Data> al=new ArrayList<Data>();
	Database db=new Database();	 
	PreparedStatement ps=Data.con.prepareStatement("select * from purchasebook");  
	ResultSet rs=ps.executeQuery();
	while(rs.next()){
		Data data=new Data();
	data.voucherno=rs.getLong(1); 
	data.companyName=rs.getString(2);
	data.paymenttype=rs.getString(3);
	data.itemcode=rs.getString(4);
	data.itemtype=rs.getString(5);
	data.rate=rs.getInt(6);
	data.designcode=rs.getString(7); 
	data.color=rs.getString(8);
	data.profit=rs.getInt(9);
	data.ratediff=rs.getInt(10); 
	data.quantity=rs.getInt(11);
	data.amount=rs.getLong(12);
	data.newdate=rs.getString(13);
	data.sno=rs.getInt(14);
	data.size=rs.getInt(15);
	data.sellingrate=rs.getInt(16);
	al.add(data);
}
	PreparedStatement ps1=Data.con.prepareStatement("select * from recentactivity");  
	ResultSet rs1=ps1.executeQuery();
	String flag="";
	long voc=0;
	if(rs1.next()){
		flag=rs1.getString("voucherflag");
		voc=rs1.getLong("voucherno");
	}
   	if(flag.equals("true")){
			%>
		<script>
			document.getElementById("barcode").disabled=false;
	</script>
	<%
		}
	%>
		     
<script>
	
	<form id="purchaseForm" action="PurchaseBookServlet" method="post">

	  <table class="table table-bordered table-striped mb-0"  width="100%">
	  <tr >
	  <th style="width:72px">Sno</th>
	  <th style="width:72px">Item Code</th>
	  <th style="width:72px">Item Name</th>
	   <th style="width:72px">Design Code</th>
	  <th style="width:72px">Color</th>
	  <th style="width:72px">Profit</th>
	  <th style="width:72px">Rate Diff</th>
	  <th style="width:72px">Pur Rate</th>
	  <th style="width:72px">Size</th>
	  <th style="width:72px">Qty</th>
	  <th style="width:72px">Total</th> 
	  <th style="width:72px">Action</th> 
	  </tr>
	  </table>
	  <div class="table-wrapper-scroll-y my-custom-scrollbar" style="position:relative;bottom:50 ;padding-bottom:100px">
	  <table class="table table-bordered table-striped mb-0" width="100%" >
	    <tbody align="center" style="padding:20px">
	   
	    <%
	   if(al.size()<=0)
		   {
		   	%>
		     <tr  align="center" border="0" style="background-color:white;width:100%;height:120px">
		       <td colspan="6" style="padding-top:40px"><b>No Items</td>
		      </tr>
		    	<% 
		   }
	   else{
		  %>
				
			  <input type="hidden" name="voucherno" value=<%=al.get(0).voucherno%>>
			  <% 
			  }
	    for(int i=0;i<al.size();i++){
	    	int val=al.get(i).rate*al.get(i).quantity;
	    %>
	    <tr >
	    <td style="width:72px" id="sno"><%=i+1%></td>
	  	<td style="width:72px" id="itemcode1"><%=al.get(i).itemcode %></td>
	  	<td style="width:72px" id="itemname1"><%=al.get(i).itemtype %></td>
	  	<td style="width:72px" id="designcode1"><%=al.get(i).designcode %></td>
	  	<td style="width:72px" id="color1"><%=al.get(i).color %></td>
	  	<td style="width:72px" id="profit1"><%=al.get(i).profit%></td>
	  	<td style="width:72px" id="ratediff1"><%=al.get(i).ratediff %></td>
	  	<td style="width:72px" id="rate1"><%=al.get(i).rate %></td>
	  	<td style="width:72px" id="size"><%=al.get(i).size %></td>
	  	<td style="width:72px" id="qty1"><%=al.get(i).quantity %></td>
	  	<td style="width:72px" id="tot1"><%=val %></td>
	  	<td style="width:72px"  style="width:15px"><button type="submit" id="delete" name="del" value="<%=al.get(i).sno %>" ><img src="css/images/delete.png" height="15px" width="15px"></button></td>
	  	
	  	</tr>
	  	
	  	<%
	  	totalamt=totalamt+val;
	    }
	  	%>					
	      </tbody>
	     </table>
	    
	     </div > 
	    
	 <script>
	 $('form').bind("keypress", function(e) {
		  if (e.keyCode == 13) {               
		    e.preventDefault();
		    return false;
		  }
		});
</script>	  

	     <table class="table table-bordered table-striped mb-0" width="100%">
	     <tr><td rowspan="2" style="padding:40px;">LR Desc</td><td rowspan="2"> <textarea id="lrdesc" name="lrdesc" placeholder="NA" class="form-control" style="width:170px;height:100px"></textarea></td><td style="width:100px">LR No.</td><td > <input type="text" name="lrno" id="lrno" placeholder="NA" class="form-control" /></td><td style="width:115px">LR date</td><td >  <input type="date" name="lrdate" id="lrdate" value="11/09/2020" class="form-control" /></td ><td colspan="2"></td><td >Total</td><td colspan="3" ><input type="text" id="total" readonly="readonly" name="total" value="<%=totalamt %>" class="form-control" /></td></tr>		
	         <tr><td >Vat</td><td><input type="number" onblur="calculateGtotal()" id="vat" name="vat" placeholder="%" value="0" class="form-control" /></td><td >Fright</td><td ><input type="number" id="fright" value="0" placeholder="%" onblur="calculateGtotal()" name="fright" class="form-control" /></td><td>Discount</td><td ><input type="number" placeholder="%" id="discount" onblur="calculateGtotal()" name="discount" value="0" class="form-control" /></td><td style="width:100px">Grand Total</td><td > <input type="text" id="grandtotal" name="grandtotal" readonly="readonly" value="<%=totalamt %>" class="form-control" /></td></tr>		
	    <tr><td  colspan="2"></td><td > <button type="button" id="new" onclick="enableForm()" style="width:100%" class="btn btn-primary" >New</button></td><td><button type="button" class="btn btn-primary " data-toggle="modal" data-target="#myModal" id="openVo"  style=" width:100%;font-size:15px;">Open</button></td><td  colspan="2"> <button type="submit" id="save" name="submit" value="save" style="width:100%" class="btn btn-primary" >Save</button></td><td  colspan="2"> <button type="submit" name="submit" id="clear" value="clear" style="width:100%" class="btn btn-danger" >Clear</button></td><td> <button type="button" id="barcode" style="width:100%" class="btn btn-success" >Generate Barcode</button></td><td colspan="2"></td></tr>		
	   
	     </table>
<% 

	PreparedStatement ps7 = Data.con.prepareStatement("select * from recentactivity");	
   ResultSet rs7=ps7.executeQuery();
   if(rs7.next()){
	  
		   PreparedStatement ps8 = Data.con.prepareStatement("select * from purchaseentry where voucherno=?");	
		   if(rs7.getString("voucheropenflag").equals("true")){
		  ps8.setLong(1, rs7.getLong("tempvoucherno"));
		   }
		   else{
			   ps8.setLong(1, rs7.getLong("voucherno"));
		   }
		  ResultSet rs8= ps8.executeQuery();
		  if(rs8.next()){
			  %>
			  <script>
			  
			  document.getElementById("vat").value=<%=rs8.getInt("vat")%>;
			  document.getElementById("fright").value=<%=rs8.getInt("fright")%>;
			  document.getElementById("discount").value=<%=rs8.getInt("discount")%>;
			  document.getElementById("lrno").value="<%=rs8.getString("lrno")%>";
			  document.getElementById("lrdesc").innerHTML="<%=rs8.getString("lrdesc")%>";
			  $(document).ready(function(){calculateGtotal();});
			  document.getElementById("lrdate").removeAttribute("type");
			  document.getElementById("lrdate").setAttribute("type", "text");
			  document.getElementById("lrdate").setAttribute("value","<%=rs8.getString("lrdate")%>");
			
			  </script>
		 <% 
		  }
	   
	   
   }
   %>
	      <script>
	   
	    	document.getElementById("dealerSelect").disabled=true;
	      document.getElementById("paytype").disabled=true;
	      document.getElementById("custData").style.visibility="hidden";
	      document.getElementById("itemcode").disabled=true;
	      document.getElementById("itemname").disabled=true;
	      document.getElementById("rate").disabled=true;
	      document.getElementById("designcode").disabled=true;
	      document.getElementById("color").disabled=true;
	      document.getElementById("profit").disabled=true;
	      document.getElementById("ratediff").disabled=true;
	      document.getElementById("save").disabled=true;
	      document.getElementById("clear").disabled=true;
	     
	  
	      function calculateGtotal(){
	   
	    	 var vat=document.getElementById("vat").value;
	    	 var fright=document.getElementById("fright").value;
	    	 var discount=document.getElementById("discount").value;

	    	 if(vat.length==0){
	    			vat=0;
	    		document.getElementById("vat").value=vat;
	    		}
	    	 if(fright.length==0){
	    			fright=0;
	    			document.getElementById("fright").value=fright;
	    		}
	    	 if(discount.length==0){
	    			discount=0;
	    			document.getElementById("discount").value=discount;
	    		}
	    	 var tax=(vat*1)+(fright*1)+(discount*1);
		    	
	    	 if(tax.length==0){
	    			tax=0;
	    		}
	    	 var tot=document.getElementById("total").value;
			var deduct=(tot*tax)/100;  
				document.getElementById("grandtotal").value=tot-deduct;
	      }
	      
	      function enableForm(){
	    	 
	    	  document.getElementById("dealerSelect").disabled=false;
		      document.getElementById("paytype").disabled=false;
		      document.getElementById("custData").style.visibility="visible";
		      document.getElementById("itemcode").disabled=false;
		      document.getElementById("itemname").disabled=false;
		      document.getElementById("rate").disabled=false;
		      document.getElementById("designcode").disabled=false;
		      document.getElementById("color").disabled=false;
		      document.getElementById("profit").disabled=false;
		      document.getElementById("ratediff").disabled=false;
		      document.getElementById("save").disabled=true;
		      document.getElementById("new").disabled=true;
		      document.getElementById("clear").disabled=false;
		   document.getElementById("barcode").disabled=true;
		      document.getElementById("openVo").disabled=true; 
	      }

	    	 
	     </script>
	     <%
	     if(al.size()>0){
	    	 %>
	    	 <script>
	    	 
	    	 document.getElementById("dealerSelect").disabled=false;
		      document.getElementById("paytype").disabled=false;
		      document.getElementById("custData").style.visibility="visible";
		      document.getElementById("itemcode").disabled=false;
		      document.getElementById("itemname").disabled=false;
		      document.getElementById("rate").disabled=false;
		      document.getElementById("designcode").disabled=false;
		      document.getElementById("color").disabled=false;
		      document.getElementById("profit").disabled=false;
		      document.getElementById("ratediff").disabled=false;
		      document.getElementById("save").disabled=false;
		      document.getElementById("clear").disabled=false;
			//document.getElementById("barcode").disabled=true;
		      document.getElementById("new").disabled=true;
		      document.getElementById("openVo").disabled=true;
		      </script>
	    	 <%
	     }
		     
	     %>
	    
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
       <input type="text" list="custdata" id="voucherInput" name="voucherInput" onkeypress="checkCustData()" class="form-control" autocomplete="off" >
        <div id="amit" style="font-size:10px;width:100% "></div>
       </input>
       
        </div>
      <div class="modal-footer">
        <input type="submit" name="submit" value="open" name="submit" class="btn btn-warning"></input>
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div> 

    <script>

$('#myModal').on('shown.bs.modal', function () {
    $('#voucherInput').focus();
})

   var request; 
	    function checkCustData()  
	    {  
	    	 
	    var bill=document.getElementById("voucherInput").value; 
	   
	    var url="OpenVoucher.jsp?val="+bill;  

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