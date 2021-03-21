<%@ page import="java.sql.*,com.*"%>

<%  
try{ 
String s=request.getParameter("val");  
boolean flag=false;

Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
PreparedStatement ps=con.prepareStatement("select * from customer where customername like ?");  
ps.setString(1,s+"%"); 

ResultSet rs=ps.executeQuery(); 
%>
<DataList id="custdata" style="height:40px;color:blue">
<%
while(rs.next()){
%>
	<option  value=<%=rs.getString(1)%>>BillNo. <%=rs.getString(2)%></option>
<%
flag=true;
}
%>
</DataList>
<%
if(flag==false){
out.print("<center><b><p style='color:red'>No Record Found</p></center>");
}
con.close();  
}catch(Exception e)
{
}  
%>
