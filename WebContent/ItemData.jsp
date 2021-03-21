<%@ page import="java.sql.*,com.*"%>

<%  
String s=request.getParameter("val");  
boolean flag=false;
if(s==null || s.trim().equals("")){  

}else{  
 
try{  
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
PreparedStatement ps=con.prepareStatement("select * from item where ItemType like ? OR ItemCode like ?");  

ps.setString(1,s+"%"); 
ps.setString(2,s+"%");


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
			<td><b>Item Name</b></td>	
			<td><b>Item Code</b></th>
			
		</tr>
		</thead>
	<%
	while(rs.next()){ 
	%>
	<tbody id="scroll">
		<tr align="center">
			<td><%=rs.getString(1)%></td>
			<td><%=rs.getString(2)%></td>
		
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

con.close();  
}catch(Exception e){e.printStackTrace();}  
}  
%>
