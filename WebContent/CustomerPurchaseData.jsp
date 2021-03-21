<%@ page import="java.sql.*,com.*"%>

<%  
long s=Long.parseLong(request.getParameter("val"));  
boolean flag=false; 
 
try{  
Database db=new Database();
Data.con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
PreparedStatement ps=Data.con.prepareStatement("select * from purchasebilldetail where billno like ?");  
ps.setLong(1,s); 

ResultSet rs=ps.executeQuery(); 
	
%>
<style type="text/css">
.my-custom-scrollbar {
position: relative;
height: 255px;
overflow: auto;
}
.table-wrapper-scroll-y {
display: block;
}
</style> 

<script type="text/javascript">
$(document).ready(function () {
	$('#dtDynamicVerticalScrollExample').DataTable({
	"scrollY": "50vh",
	"scrollCollapse": true,
	});
	$('.dataTables_length').addClass('bs-select');
	});

</script>

<div class="table-wrapper-scroll-y my-custom-scrollbar table-responsive text-nowrap">
  <table class="table table-bordered table-striped mb-0">
		<thead>
		<tr align="center">
			<td><b>Bill No.</b></td>	
			<td><b>Item Name</b></th>
			<td><b>Color</b></th>
			<td><b>Size</b></th>
			<td><b>Quantity</b></th>
			<td><b>Price</b></th>
		</tr>
		</thead>
	<%
	while(rs.next()){ 
	%>
	<tbody id="scroll">
		<tr align="center">
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(4)%></td>
			<td><%=rs.getString(5)%></td>
			<td><%=rs.getString(6)%></td>
			<td><%=rs.getString(7)%></td>
			<td><%=rs.getString(8)%></td>
		</tr>
</tbody>
<% 
flag=true;
} 
%>
	<table>
	</div>
	<%
if(flag==false){
	out.print("<html><body><center><b> No Record Found</enter></body></html>");
}
 
}catch(Exception e){e.printStackTrace();
}  

%>
