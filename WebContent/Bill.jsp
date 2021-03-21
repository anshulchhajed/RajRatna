<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
     
     <script type="text/javascript">
     function printDiv() {
         var printContents = document.getElementById('printdiv').innerHTML;
         var originalContents = document.body.innerHTML;

         document.body.innerHTML = printContents;

         window.print();

         document.body.innerHTML = originalContents;
    }
      
    </script>
    <style type="text/css">
    @media screen{
    #printdiv{
      display:none;
    }
  
    }
    </style>
  
 </head>


<%
Database db=new Database();
Data data=new Data();
PreparedStatement ps=null;
ArrayList<Data> list=null;
ResultSet rs=null;
String newDate=null;
try{

ArrayList<Data>al=db.getRecentActivity();
if(al.get(0).openflag.equals("true")){
	data.billno=al.get(0).tempbillno;
}
else{
	data.billno=al.get(0).billno;	
}

data.date=al.get(0).date;
data.tinNo=al.get(0).tinNo;
SimpleDateFormat frmt=new SimpleDateFormat("dd/MM/yyyy");
newDate=frmt.format(data.date);
Data.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");
 ps = Data.con.prepareStatement("select * from purchasebilldetail where billno=?");
ps.setLong(1,data.billno);
 rs = ps.executeQuery();	
if(rs.next()){
data.itempurchased=rs.getInt("itempurchased");
data.custname=rs.getString("customername");
data.custmobileno=rs.getLong("customermobile");	
data.discount=rs.getInt("discount");
data.discountamount=rs.getInt("discountamount");
data.amountpaid=rs.getInt("amountpaid");
data.adjustamount=rs.getInt("adjustamount");
}
 ps= Data.con.prepareStatement("select * from customerpurchasedetail where billno=?");
ps.setLong(1,data.billno);
list=new ArrayList<Data>();
 rs = ps.executeQuery();	
while(rs.next()){
Data data1=new Data();
data1.itemcode=rs.getString("itemcode");
data1.itemtype=rs.getString("itemname");
data1.size=rs.getInt("size");
data1.quantity=rs.getInt("quantity");
data1.price=rs.getInt("price");
list.add(data1);
}
}
catch(Exception e){
	
}

%>
       <div id="printdiv" class="invoice-box" align="center">
        
        <table   style="font-size:8px;font-family:courier">
            <tr>
               
                            <td align="center" style="width:30px; padding-bottom:10px">
                             <img src="css/images/r.png" style="height:50px; width:50px">
                            </td>
                            <td colspan="3" align="left">
                             <h4><b>&nbsp;<u>RAJ RATNA</u></b></h4>&nbsp;&nbsp;&nbsp;Readymade Showroom<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Main Road,Karhi
                            </td>
                        </tr>
   
            <tr class="information">
                <td colspan="4">
                    <table  align="center"  style="width:100%">
                        <tr>
                            <td width="40%">
                            <br>
                            &nbsp;Tin No.  : <%=data.tinNo %><br>
                            &nbsp;Bill No.  : <%=data.billno %><br>
                            &nbsp;Bill Date : <%=newDate %><br>
                                
                            </td>
                            
                            <td align="right">
                              Name:<%=data.custname %>&nbsp;<br>
                              Mobile No:<%=data.custmobileno %>&nbsp;<br>
                            </td>
                        </tr>
                    </table>
               =================================================================
                </td>
            </tr>
            
           
            <tr >
                <td style="width:40%">
                   &nbsp;<b>Particulars
                </td>
               
                <td align="center">
                    &nbsp;<b>Qty
                </td>
                <td align="right">
                    <b>Rate
                </td>
                 
                <td align="right" >
                   <b>Amount &nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr><td colspan="4">=================================================================</td></tr>
            <% 
            int sum=0;
            for(int i=0;i<list.size();i++){
            %>
            <tr class="item" >
                <td align="left">
                   123456&nbsp;<%=list.get(i).itemtype %>
                </td>
                  <td align="center">
                   <%=list.get(i).quantity %>
                </td>
                <td align="right">
                    <%=list.get(i).price %>
                </td>
                <td align="right">
                    <%=list.get(i).price*list.get(i).quantity  %>/- &nbsp;&nbsp;&nbsp;<br>
                </td>
            </tr>
            <%
            sum=sum+(list.get(i).price*list.get(i).quantity);
            }
            %>
          <tr><td colspan="4">----------------------------------------------------------------</td></tr>
            <tr class="item" >
                <td></td>
                <td></td>
                <td></td>
                <td align="right">
                  <b>Gross:<%=sum %>/-&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            
             <tr class="item" >
                <td></td>
                <td></td>
                <td></td>
                <td align="right">
                 <b> Discount:<%=data.discountamount+data.adjustamount%>/-&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            
             <tr class="item" >
                <td></td>
                <td></td>
                <td></td>
                <td align="right">
                  <b> Net: <%=data.amountpaid %>/-&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table></center>
        
    </div>
