n<%@ page import="java.sql.*,com.*"%>

<%  
PreparedStatement ps=null;
String s=request.getParameter("val");  
boolean flag=false;
if(s==null || s.trim().equals("")){  

}else{  
 
try{  
Database db=new Database();
Data.con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
ps=Data.con.prepareStatement("select * from customer where customername like ?");  

ps.setString(1,s+"%"); 

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
			<td><b>Customer Name</b></td>	
			<td><b>Customer Mobile No.</b></th>
			
		</tr>
		</thead>
	<%
	while(rs.next()){ 
	%>
	<tbody id="scroll">
		<tr align="center">
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getLong(2)%></td>
			
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
  
}catch(Exception e){e.printStackTrace();}  
}  
%>
