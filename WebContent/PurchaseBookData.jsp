<%@page import="java.io.IOException"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.*,com.*"%>

<%
PreparedStatement ps=null;
String itemcode=request.getParameter("val1"); 
String itemname=request.getParameter("val2"); 
int rate=Integer.parseInt(request.getParameter("val3")); 
String designcode=request.getParameter("val4"); 
String color=request.getParameter("val5"); 
int profit=Integer.parseInt(request.getParameter("val6")); 
int ratediff=Integer.parseInt(request.getParameter("val7")); 
int quantity=Integer.parseInt(request.getParameter("val8")); 
long amount=Long.parseLong(request.getParameter("val9")); 
String dealername=request.getParameter("val10"); 
String paytype=request.getParameter("val11"); 
long voucher=Long.parseLong(request.getParameter("val12")); 
String date=request.getParameter("val13"); 
String size=request.getParameter("val14"); 
String actualrate=request.getParameter("val15");
String qty=request.getParameter("val16");
String newsize[]=size.split(",");
String newrate[]=actualrate.split(",");
String newqty[]=qty.split(",");
int totalitem=0;
int totalamt=0;

for(int i=0;i<newqty.length;i++){
	int qtyval=Integer.parseInt(newqty[i]);
	totalitem=totalitem+qtyval;
}
totalamt=(totalitem*rate);
int rowcount=newsize.length;
try{  
Database db=new Database();  
int row=db.getPurchaseRowCount();
for(int i=0;i<rowcount;i++){ 
ps=Data.con.prepareStatement("insert into purchasebook values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");  
ps.setLong(1,voucher); 
ps.setString(2,dealername);
ps.setString(3,paytype);
ps.setString(4,itemcode); 
ps.setString(5,itemname);
ps.setInt(6,rate);
ps.setString(7,designcode); 
ps.setString(8,color);
ps.setInt(9,profit);
ps.setInt(10,ratediff);
ps.setInt(11,Integer.parseInt(newqty[i])); 
ps.setLong(12,amount);
ps.setString(13,date);
ps.setInt(14,(i+row+1));
ps.setInt(15,Integer.parseInt(newsize[i]));
ps.setInt(16,Integer.parseInt(newrate[i])); 


int x =ps.executeUpdate();
}
}
catch(Exception e){
	e.printStackTrace();
} 

ps=Data.con.prepareStatement("insert into rajratna.purchaseentry (voucherno, companyname, totalqty, totalamount) values(?,?,?,?)");  
ps.setLong(1,voucher); 
ps.setString(2,dealername);
ps.setInt(3,totalitem);
ps.setLong(4,totalamt);

int y =ps.executeUpdate(); 
  %>