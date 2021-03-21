<%@ page import="java.sql.*,com.*"%>

<%  
PreparedStatement ps=null;
ResultSet rs=null;
String s=request.getParameter("val");  
boolean flag=false;
if(s==null || s.trim().equals("")){  

}else{  
 
try{  
	
Database db=new Database();
Data.con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
 ps=Data.con.prepareStatement("select * from dealers where companyname like ?");  
if(!s.equals("all")){
ps.setString(1,s+"%"); 
 rs=ps.executeQuery(); 
}
else{

		 ps=Data.con.prepareStatement("select * from dealers");  
		 rs=ps.executeQuery(); 
	}
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
			<td><b>Company Name</b></td>	
			<td><b>Address</b></th>
			<td><b>Contact</b></th>
			<td><b>Account No</b></th>
			<td><b>Bank Name</b></th>
			<td><b>IFSC Code</b></th>
		</tr>
		</thead>
	<%
	while(rs.next()){ 
	%>
	<tbody id="scroll">
		<tr align="center">
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(2)%></td>
			<td><%=rs.getLong(3)%></td>
			<td><%=rs.getLong(4)%></td>
			<td><%=rs.getString(5)%></td>
			<td><%=rs.getString(6)%></td>
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
