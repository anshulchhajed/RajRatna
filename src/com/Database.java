package com;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
public class Database
{

	PreparedStatement ps=null;
	PreparedStatement ps1=null;

	ResultSet rs=null;
	public Database() 
	{
		try {
			if(Data.con==null || Data.con.isClosed()) {
				Data.con=getConnection();

			}


		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Connection getConnection() {

		try {

			Class.forName("com.mysql.jdbc.Driver");
			Data.con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return Data.con;
	}


	public  ArrayList getLogin(Data obj)
	{     
		ArrayList al=new ArrayList();
		try
		{
			ps=Data.con.prepareStatement("select * from userlogin where login_id=? and login_password=? and user_type=?");
			ps.setString(1,obj.login_id);
			ps.setString(2,obj.login_password);
			ps.setString(3,obj.user_type);
			rs=ps.executeQuery();
			if(rs.next())
			{	Data obj1=new Data();

			obj1.user_type=rs.getString("user_type");
			obj1.userName=rs.getString("user_name");
			al.add(obj1);	
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getLogin() function "+e);
		}
		return al;
	}


	public  ArrayList getEmpData()
	{     
		ArrayList al=new ArrayList();
		try
		{
			ps=Data.con.prepareStatement("select * from emp");
			rs=ps.executeQuery();
			while(rs.next())
			{	
				Data obj1=new Data();
				obj1.empid=rs.getString("empid");
				obj1.empname=rs.getString("empname");
				obj1.emplocn=rs.getString("emplocn");
				obj1.empsalary=rs.getString("empsalary");
				al.add(obj1);	
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getemp data "+e);
		}
		return al;
	}

	public  boolean insertEmpData(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("insert into emp values(?,?,?,?)");
			ps.setString(1,data.empid);
			ps.setString(2,data.empname);
			ps.setString(3,data.emplocn);
			ps.setString(4,data.empsalary);
			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in check() function "+e);
		}
		return flag;
	}

	public  boolean deleteEmpData(String data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from emp where empid=?");
			ps.setString(1,data);

			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in check() function "+e);
		}
		return flag;
	}

	public  boolean updateEmpData(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("update emp set empid=?,empname=?,emplocn=?,empsalary=?");
			ps.setString(1,data.empid);
			ps.setString(2,data.empname);
			ps.setString(3,data.emplocn);
			ps.setString(4,data.empsalary);
			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in check() function "+e);
		}
		return flag;
	}


	public  boolean insertDealer(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("insert into dealers values(?,?,?,?,?,?)");
			ps.setString(1,data.companyName);
			ps.setString(2,data.address);
			ps.setLong(3,data.contact);
			ps.setLong(4,data.accountNo);
			ps.setString(5,data.bankName);
			ps.setString(6,data.ifcsCode);

			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in insertDealer() function "+e);
		}

		return flag;
	}


	public  boolean updateDealer(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("update dealers set address=?,Data.contact=?,accountno=?,bankname=?,ifsc=? where companyname=?");

			ps.setString(1,data.address);
			ps.setLong(2,data.contact);
			ps.setLong(3,data.accountNo);
			ps.setString(4,data.bankName);
			ps.setString(5,data.ifcsCode);
			ps.setString(6,data.companyName);

			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in updateDealer() function "+e);
		}

		return flag;
	}
	public  boolean deleteDealer(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from dealers where companyname=?");

			ps.setString(1,data.companyName);

			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in deleteDealer() function "+e);
		}

		return flag;
	}
	public  ArrayList<Data> getDealerList()
	{     
		ArrayList<Data> al=new ArrayList();
		try
		{
			ps=Data.con.prepareStatement("select * from dealers");
			rs=ps.executeQuery();
			while(rs.next())
			{	
				Data obj1=new Data();
				obj1.companyName=rs.getString("companyname");
				obj1.contact=rs.getLong("contact");
				obj1.address=rs.getString("address");
				obj1.accountNo=rs.getLong("accountno");
				obj1.bankName=rs.getString("bankname");
				obj1.ifcsCode=rs.getString("ifsc");

				al.add(obj1);	
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in getDealerList "+e);
		}

		return al;
	}

	public  ArrayList<Data> fetchDealer(Data data)
	{     
		ArrayList<Data> al=new ArrayList();
		try
		{
			ps=Data.con.prepareStatement("select * from dealers where companyname=?");
			ps.setString(1,data.companyName);
			rs=ps.executeQuery();
			if(rs.next())
			{	
				Data obj1=new Data();
				obj1.companyName=rs.getString("companyname");
				obj1.contact=rs.getLong("Data.contact");
				obj1.address=rs.getString("address");
				obj1.accountNo=rs.getLong("accountno");
				obj1.bankName=rs.getString("bankname");
				obj1.ifcsCode=rs.getString("ifsc");

				al.add(obj1);	
			}
			else {
				al=null;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in fetchDealer "+e);
		}

		return al;
	}

	public  ArrayList<Data> getStock(String itemcode)
	{     
		ArrayList al=new ArrayList();
		try
		{
			ps=Data.con.prepareStatement("select * from stock where itemcode=?");
			ps.setString(1,itemcode);
			rs=ps.executeQuery();
			if(rs.next())
			{	Data obj1=new Data();

			obj1.itemcode=rs.getString("itemcode");
			obj1.purchaseid=rs.getString("purchaseid");
			obj1.categoryid=rs.getString("categoryid");
			obj1.itemtype=rs.getString("itemtype");
			obj1.color=rs.getString("color");
			obj1.size=rs.getInt("size");
			obj1.quantity=rs.getInt("quantity");
			obj1.price=rs.getInt("price");
			obj1.size=rs.getInt("size");

			al.add(obj1);	
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getLogin() function "+e);
		}

		return al;
	}

	public  ArrayList<Data> getTempStock(String itemcode)
	{     
		ArrayList al=new ArrayList();
		try
		{
			ps=Data.con.prepareStatement("select * from tempstock where itemcode=?");
			ps.setString(1,itemcode);
			rs=ps.executeQuery();
			if(rs.next())
			{	Data obj1=new Data();

			obj1.itemcode=rs.getString("itemcode");
			obj1.purchaseid=rs.getString("purchaseid");
			obj1.categoryid=rs.getString("categoryid");
			obj1.itemtype=rs.getString("itemtype");
			obj1.color=rs.getString("color");
			obj1.size=rs.getInt("size");
			obj1.quantity=rs.getInt("quantity");
			obj1.currQuantity=rs.getInt("currQuantity");
			obj1.price=rs.getInt("price");
			obj1.currPrice=rs.getInt("currPrice");

			al.add(obj1);	
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getLogin() function "+e);
		}

		return al;
	}

	public  ArrayList<Data> getTempStock(long billno)
	{     
		ArrayList<Data> al=new ArrayList<Data>();
		try
		{
			ps=Data.con.prepareStatement("select * from tempstock where billno=?");
			ps.setLong(1,billno);
			rs=ps.executeQuery();
			while(rs.next())
			{	Data obj1=new Data();
			obj1.itemcode=rs.getString("itemcode");
			obj1.purchaseid=rs.getString("purchaseid");
			obj1.categoryid=rs.getString("categoryid");
			obj1.itemtype=rs.getString("itemtype");
			obj1.color=rs.getString("color");
			obj1.size=rs.getInt("size");
			obj1.quantity=rs.getInt("quantity");
			obj1.currQuantity=rs.getInt("currQuantity");
			obj1.price=rs.getInt("price");
			obj1.currPrice=rs.getInt("currPrice");
			al.add(obj1);	
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getTempStock() function "+e);
		}

		return al;
	}


	public  boolean updateTempStock(ArrayList<Data> list)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from tempstock where itemcode=?");
			ps.setString(1,list.get(0).itemcode);
			rs=ps.executeQuery();
			Data obj1=new Data();
			if(rs.next())
			{	

				obj1.quantity=rs.getInt("quantity");
				obj1.currQuantity=rs.getInt("currQuantity")+1;
				obj1.price=rs.getInt("price");
				System.out.println("Quantity"+obj1.quantity);
				System.out.println("Quantity"+obj1.currQuantity);
				if(obj1.currQuantity<=obj1.quantity) {
					ps=Data.con.prepareStatement("update tempstock set currQuantity=?, currPrice=? where itemcode=?");
					ps.setInt(1,obj1.currQuantity);
					ps.setInt(2,(obj1.currQuantity*obj1.price));
					ps.setString(3,list.get(0).itemcode);
					int x=ps.executeUpdate();
					if(x>0)
					{
						flag=true;
					}
					else
					{
						flag=false;
					}
				}
				else 
				{
					flag=false;
				}
			}	
			else {

				ps=Data.con.prepareStatement("select * from recentactivity");
				rs=ps.executeQuery();
				if(rs.next()) {
					String openFlag=rs.getString("openFlag");
					if(openFlag.equals("true")) {
						obj1.billno=rs.getLong("tempbillno");			
					}
					else {
						obj1.billno=rs.getLong("lastbillno");		
					}

				}

				ps=Data.con.prepareStatement("insert into tempstock values(?,?,?,?,?,?,?,?,?,?,?)");
				ps.setLong(1,obj1.billno);
				ps.setString(2,list.get(0).itemcode);
				ps.setString(3,list.get(0).purchaseid);
				ps.setString(4,list.get(0).categoryid);
				ps.setString(5,list.get(0).itemtype);
				ps.setString(6,list.get(0).color);
				ps.setInt(7,list.get(0).size);
				ps.setInt(8,list.get(0).quantity);
				ps.setInt(9,1);
				ps.setInt(10,list.get(0).price);
				ps.setInt(11,list.get(0).price);
				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;

				}
				else
				{
					flag=false;
				}
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in updateTempStock() function "+e);
		}

		return flag;
	}
	public  boolean minusTempStockQty(String itemcode)
	{     
		boolean flag=false;
		try
		{
			ArrayList<Data> al=getTempStock(itemcode);
			if(al.get(0).currQuantity>=1) {
				ps=Data.con.prepareStatement("update tempstock set currQuantity=?, currPrice=? where itemcode=?");
				ps.setInt(1,(al.get(0).currQuantity-1));
				ps.setInt(2,(al.get(0).currPrice-al.get(0).price));
				ps.setString(3,itemcode);

				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;
				}
				else
				{
					flag=false;
				}
			}
			/*	else {
				ps=Data.con.prepareStatement("delete from tempstock where itemcode=?");
				ps.setString(1,itemcode);
				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;
				ArrayList<Data> list=getStock(itemcode);
				ps=Data.con.prepareStatement("update stock set quantity=? where itemcode=?");
				ps.setInt(1,(list.get(0).quantity+1));
				ps.setString(2,itemcode);
				 x=ps.executeUpdate();
				if(x>0) {
					flag=true;	
				}
				else {
					flag=false;
				}

				}
				else
				{
					flag=false;
				}
			}*/
		}
		catch(Exception e)
		{
			System.out.println("problem in minusTempStock() function "+e);
		}


		return flag;
	}

	public  boolean addTempStockQty(String itemcode)
	{     
		boolean flag=false;
		try
		{
			ArrayList<Data> al=getTempStock(itemcode);
			Data data=new Data();
			data.quantity=al.get(0).quantity;
			data.currQuantity=al.get(0).currQuantity;
			data.currPrice=al.get(0).currPrice;
			data.price=al.get(0).price;

			if(data.currQuantity<data.quantity) {
				ps=Data.con.prepareStatement("update tempstock set currQuantity=?, currPrice=? where itemcode=?");
				ps.setInt(1,(data.currQuantity+1));
				ps.setInt(2,(data.currPrice+data.price));
				ps.setString(3,itemcode);
				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;
				}
				else
				{
					flag=false;
				}
			}
			else {
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in minusTempStock() function "+e);
		}
		return flag;
	}


	public  boolean updatePurchaseBill(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from purchasebilldetail where billno=?");
			ps.setLong(1,data.billno);
			System.out.println("Bill No."+data.billno);
			ResultSet rs=ps.executeQuery();
			ArrayList<Data>al=getRecentActivity();
			if(rs.next()) {
				System.out.println("Inside Update");
				ps=Data.con.prepareStatement("update purchasebilldetail set itempurchased=?,totalprice=?,discount=?,discountamount=?,adjustamount=?,amountpaid=?,Date=? where billno=?");
				ps.setInt(1,data.itempurchased);
				ps.setInt(2,data.totalprice);
				ps.setInt(3,data.discount);
				ps.setInt(4,data.discountamount);
				ps.setInt(5,data.adjustamount);
				ps.setInt(6,data.amountpaid);
				ps.setDate(7,al.get(0).date);
				ps.setLong(8,data.billno);
				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;
				}
				else
				{
					flag=false;
				}
			}
			else {
				System.out.println("Inside Insert Query");
				ps=Data.con.prepareStatement("insert into purchasebilldetail values(?,?,?,?,?,?,?,?,?,?)");
				ps.setString(1,al.get(0).custname);
				ps.setLong(2,al.get(0).custmobileno);
				ps.setLong(3,data.billno);
				ps.setInt(4,data.itempurchased);
				ps.setInt(5,data.totalprice);
				ps.setInt(6,data.discount);
				ps.setInt(7,data.discountamount);
				ps.setInt(8,data.adjustamount);
				ps.setInt(9,data.amountpaid);
				ps.setDate(10,al.get(0).date);
				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;
				}
				else
				{
					flag=false;
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in updatePurchaseBill() function "+e);
		}
		return flag;
	}

	public  boolean updateCustomerPurchase(long billno)
	{     
		boolean flag=false;
		try
		{
			ArrayList<Data> al=new ArrayList<Data>();
			rs=null;
			ps=Data.con.prepareStatement("select * from tempstock where billno=?");
			ps.setLong(1,billno);
			rs=ps.executeQuery();
			while(rs.next()) {
				Data data=new Data();
				data.itemcode=rs.getString("itemcode");
				data.itemtype=rs.getString("itemtype");	
				data.size=rs.getInt("size");
				data.currQuantity=rs.getInt("currQuantity");
				data.price=rs.getInt("price");
				al.add(data);
			}
			for(int i=0;i<al.size();i++) {
				Data data=al.get(i);
				ps=Data.con.prepareStatement("select * from customerpurchasedetail where billno=? and itemcode=?");
				ps.setLong(1, billno);
				ps.setString(2, data.itemcode);
				rs=ps.executeQuery();
				if(rs.next()) {
					ps=Data.con.prepareStatement("update customerpurchasedetail set quantity=? where billno=? and itemcode=?");

					ps.setInt(1,data.currQuantity);
					ps.setLong(2,billno);
					ps.setString(3,data.itemcode);

					int x=ps.executeUpdate();
					if(x>0)
					{	flag=true;
					}
					else
					{
						flag=false;
					}
				}
				else {
					ps=Data.con.prepareStatement("insert into customerpurchasedetail values(?,?,?,?,?,?)");
					ps.setLong(1,billno);
					ps.setString(2,data.itemcode);
					ps.setString(3,data.itemtype);
					ps.setInt(4,data.size);
					ps.setInt(5,data.currQuantity);
					ps.setInt(6,data.price);
					int x=ps.executeUpdate();
					if(x>0)
					{	flag=true;
					}
					else
					{
						flag=false;
					}
				}
			}
			int count=0;
			ps=Data.con.prepareStatement("select * from customerpurchasedetail where billno=?");
			ps.setLong(1, billno);
			rs=ps.executeQuery();
			while(rs.next()) {
				count++;
			}
			System.out.println(count);
			if(al.size()<count) {
				ps=Data.con.prepareStatement("delete from customerpurchasedetail where billno=? and customerpurchasedetail.itemcode not in (select itemcode from tempstock where billno=?)");
				ps.setLong(1, billno);
				ps.setLong(2, billno);
				int x=ps.executeUpdate();
				if(x>0)
				{	flag=true;
				}
				else
				{
					flag=false;
				}

			}
		}
		catch(Exception e)
		{
			System.out.println("problem in updateCustomerPurchase() function "+e);
		}
		return flag;
	}

	public  boolean cleanTempStock(long billno)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from tempstock where billno=?");
			ps.setLong(1,billno);
			int x=ps.executeUpdate();
			if(x>0)
			{	
				flag=true;
			}
			else {
				flag=false;
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in cleanTempStock() function "+e);
		}
		return flag;
	}

	public  boolean checkTempStockWithNull(long billno)
	{     
		boolean flag=false;
		ArrayList<Data> al=new ArrayList<>();
		try
		{
			ps=Data.con.prepareStatement("select * from tempstock where billno=?");
			ps.setLong(1,billno);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{	
				if(rs.getInt("currQuantity")==0){
					flag=true;
				}
				else {
					flag=false;
				}
			}


		}
		catch(Exception e)
		{
			System.out.println("problem in checkTempStockWithNull() function "+e);
		}
		return flag;
	}


	public  boolean checkTempStockWithNoData(long billno)
	{     
		boolean flag=false;
		ArrayList<Data> al=new ArrayList<>();
		try
		{
			ps=Data.con.prepareStatement("select * from tempstock where billno=?");
			ps.setLong(1,billno);
			ResultSet rs=ps.executeQuery();
			if(rs.next())
			{	
				flag=false;
			}
			else {
				flag=true;
			}


		}
		catch(Exception e)
		{
			System.out.println("problem in checkTempStockWithNull() function "+e);
		}
		return flag;
	}

	public  boolean updateActualStock(long billno)
	{     
		boolean flag=false;

		try
		{
			ArrayList<Data>al=getRecentActivity();
			ArrayList<Data>al1=new ArrayList<Data>();
			ps=Data.con.prepareStatement("select * from tempstock where billno=?");
			ps.setLong(1,billno);
			rs=ps.executeQuery();
			while(rs.next()){
				Data data=new Data();
				data.itemcode=rs.getString("itemcode");
				data.currQuantity=rs.getInt("currQuantity");
				data.quantity=rs.getInt("quantity");
				al1.add(data);
			}

			for(int i=0;i<al1.size();i++) {

				ps=Data.con.prepareStatement("update stock set quantity=? where itemcode=?");
				ps.setInt(1,(al1.get(i).quantity-al1.get(i).currQuantity));
				ps.setString(2,al1.get(i).itemcode);

				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;	
				}
				else {
					flag=false;
				}

			}


		}
		catch(Exception e)
		{
			System.out.println("problem in cleanTempStock() function "+e);
		}
		return flag;
	}

	public  boolean updateRecentActivity(long billno)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity");
			rs=ps.executeQuery();
			if(rs.next()){
				ps=Data.con.prepareStatement("update recentactivity set UsedFlag=?,Date=?");
				ps.setString(1,"true");
				long millis=System.currentTimeMillis();  
				java.sql.Date date=new java.sql.Date(millis);  
				ps.setDate(2,date);
				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;
				}
				else {
					flag=false;
				}
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in updateRecentActivity() function "+e);
		}
		return flag;
	}

	public  boolean updateRecentActivityVoucher(long voucherno)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity");
			rs=ps.executeQuery();
			if(rs.next()){
				ps=Data.con.prepareStatement("update recentactivity set voucherflag=?,voucherdate=?");
				ps.setString(1,"true");
				long millis=System.currentTimeMillis();  
				java.sql.Date date=new java.sql.Date(millis);  
				ps.setDate(2,date);
				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;
				}
				else {
					flag=false;
				}
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in updateRecentActivityVoucher() function "+e);
		}
		return flag;
	}



	public  boolean updateRecentActivityVoucher(String vflag)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity");
			rs=ps.executeQuery();
			if(rs.next()){
				ps=Data.con.prepareStatement("update recentactivity set voucherflag=?");
				ps.setString(1,vflag);
				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;
				}
				else {
					flag=false;
				}
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in updateRecentActivityVoucher() function "+e);
		}
		return flag;
	}

	
	public  boolean updateRecentActivityVoucherNo()
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity");
			rs=ps.executeQuery();
			if(rs.next()){
				String openflag=rs.getString("voucheropenflag");
				if(openflag.equals("true")) {
					ps=Data.con.prepareStatement("update recentactivity set voucheropenflag=?");
					ps.setString(1,"false");
					int x=ps.executeUpdate();
					if(x>0)
					flag=true;
				}
				else {
					long voc=rs.getLong("voucherno");
					ps=Data.con.prepareStatement("update recentactivity set voucherno=?");
					ps.setLong(1,voc+1);
					int x=ps.executeUpdate();
					if(x>0) {
						flag=true;
					}
					else {
						flag=false;
					}	
				}
				
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in updateRecentActivityVoucher() function "+e);
		}
		return flag;
	}
	

	public  boolean updateRecentActivityOpenFlag()
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity");
			rs=ps.executeQuery();
			if(rs.next()){
				String openflag=rs.getString("voucheropenflag");
				if(openflag.equals("true")) {
					ps=Data.con.prepareStatement("update recentactivity set voucheropenflag=?");
					ps.setString(1,"false");
					int x=ps.executeUpdate();
					if(x>0)
					flag=true;
				}
				
				
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in updateRecentActivityOpenFlag() function "+e);
		}
		return flag;
	}
	
	public  boolean updateRecentActivityBill(long billno)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity where UsedFlag=?");
			ps.setString(1,"true");
			rs=ps.executeQuery();
			if(rs.next()){
				ps=Data.con.prepareStatement("update recentactivity set lastbillno=?, UsedFlag=?,openFlag=?,customername=?,customermobile=?");
				ps.setLong(1,rs.getLong("lastbillno")+1);
				ps.setString(2,"false");
				ps.setString(3,"false");
				ps.setString(4,"NA");
				ps.setLong(5,0);

				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;
				}
				else {
					flag=false;
				}
			}
			else {

			}

		}
		catch(Exception e)
		{
			System.out.println("problem in updateRecentActivityBill() function "+e);
		}
		return flag;
	}

	public  ArrayList<Data> getRecentActivity()
	{     

		ArrayList<Data> al=new ArrayList<Data>();

		try
		{
			ps=Data.con.prepareStatement("select * from recentactivity");
			rs=ps.executeQuery();
			if(rs.next()){
				Data data=new Data();
				data.billno=rs.getLong("lastbillno");
				data.tempbillno=rs.getLong("tempbillno");
				data.flag=rs.getString("UsedFlag");
				data.openflag=rs.getString("openFlag");
				data.custname=rs.getString("customername");
				data.custmobileno=rs.getLong("customermobile");
				data.tinNo=rs.getLong("tinno");
				data.date=rs.getDate("Date");
				al.add(data);
			}
			else {
				al=null;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getRecentActivity() function "+e);
		}
		return al;

	}


	public  boolean addCustomer(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from customer where customermobile=?");
			ps.setLong(1,data.custmobileno);
			rs=ps.executeQuery();
			if(rs.next()) {
				flag=true;	
			}
			else {

				ps=Data.con.prepareStatement("insert into customer values(?,?)");
				ps.setString(1,data.custname);
				ps.setLong(2,data.custmobileno);
				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;	
				}
				else {
					flag=false;
				}
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in addCustomer() function "+e);
		}
		return flag;
	}

	public  boolean cleanNullPurchaseHistory(Long data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from purchasebilldetail where billno=? and itempurchased=? ");
			ps.setLong(1,data);
			ps.setInt(2,0);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;	
			}
			else {
				flag=false;
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in cleanNullPurchaseHistory() function "+e);
		}
		return flag;
	}

	public  boolean deletePurchaseBill(long billno)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from purchasebilldetail where billno=?");
			ps.setLong(1,billno);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;	
			}
			else {
				flag=false;
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in deletePurchaseBill() function "+e);
		}
		return flag;
	}

	public  boolean deleteCustomerPurchase(long bill)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from customerpurchasedetail where billno=?");
			ps.setLong(1,bill);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;	
			}
			else {
				flag=false;
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in deleteCustomerPurchase() function "+e);
		}
		return flag;
	}

	public  boolean deleteCustomerPurchaseWithNull(long bill)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from customerpurchasedetail where billno=? and quantity=?");
			ps.setLong(1,bill);
			ps.setInt(2,0);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;	
			}
			else {
				flag=false;
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in deleteCustomerPurchase() function "+e);
		}
		return flag;
	}

	public  ArrayList<Data> getCustomerPurchase(long bill)
	{     
		ArrayList<Data> al=new ArrayList<>();

		try
		{
			ps=Data.con.prepareStatement("select * from customerpurchasedetail where billno=?");
			ps.setLong(1,bill);
			rs=ps.executeQuery();
			while(rs.next()) {
				Data data=new Data();
				data.itemcode =rs.getString("itemcode");
				data.quantity=rs.getInt("quantity");
				al.add(data);
			}
		}

		catch(Exception e)
		{
			System.out.println("problem in deleteCustomerPurchase() function "+e);
		}
		return al;
	}

	public  boolean updateActualStock(ArrayList<Data> al)
	{     
		boolean flag=false;
		try
		{
			ArrayList<Data> list;

			for(int i=0;i<al.size();i++) {
				list=getStock(al.get(i).itemcode);	
				ps=Data.con.prepareStatement("update stock set quantity=? where itemcode=?");
				ps.setInt(1,list.get(0).quantity+al.get(i).quantity);
				ps.setString(2,al.get(i).itemcode);	
				int x=ps.executeUpdate();
				if(x>0) {
					flag=true;	
				}
				else {
					flag=false;
				}
			}

		}

		catch(Exception e)
		{
			System.out.println("problem in updateActualStock() function "+e);
		}
		return flag;
	}


	public  boolean addItem(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("insert into item values(?,?)");
			ps.setString(1,data.itemtype);
			ps.setString(2,data.itemcode);
			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in addItem() function "+e);
		}
		return flag;
	}

	public  boolean updateItem(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("update item set ItemCode=? where ItemType=?");
			ps.setString(1,data.itemcode);
			ps.setString(2,data.itemtype);
			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in updateItem() function "+e);
		}
		return flag;
	}

	public  boolean deleteItem(Data data)
	{     
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("delete from item where ItemType=? and ItemCode=?");
			ps.setString(1,data.itemtype);
			ps.setString(2,data.itemcode);
			int x=ps.executeUpdate();
			if(x>0)
			{	flag=true;
			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in deleteItem() function "+e);
		}
		return flag;
	}


	public  ArrayList<Data> getItem()
	{     
		ArrayList<Data> al=new ArrayList<Data>();
		try
		{
			ps=Data.con.prepareStatement("select * from item");

			rs=ps.executeQuery();
			while(rs.next()) {
				Data data=new Data();
				data.itemtype=rs.getString(1);
				data.itemcode=rs.getString(2);
				al.add(data);

			}
		}
		catch(Exception e)
		{
			System.out.println("problem in getItem() function "+e);
		}

		return al;
	}



	public  boolean openBillData(long billno)
	{     
		ArrayList<Data> al=new ArrayList<Data>();
		boolean flag=false;
		try
		{
			ps=Data.con.prepareStatement("select * from customerpurchasedetail where billno=?");
			ps.setLong(1, billno);
			rs=ps.executeQuery();
			while(rs.next()) {
				Data data=new Data();
				data.billno=billno;
				data.itemcode=rs.getString("itemcode");
				data.itemtype=rs.getString("itemname");
				data.size=rs.getInt("size");
				data.currQuantity=rs.getInt("quantity");
				data.currPrice=rs.getInt("price")*data.currQuantity;
				ps1=Data.con.prepareStatement("select * from stock where itemcode=?");
				ps1.setString(1, data.itemcode);
				ResultSet rs1=ps1.executeQuery();
				if(rs1.next()) {
					data.purchaseid=rs1.getString("purchaseid");
					data.categoryid=rs1.getString("categoryid");
					data.color=rs1.getString("color");
					data.quantity=rs1.getInt("quantity");
					data.price=rs1.getInt("price");
				}
				al.add(data);
			}
			for(int i=0;i<al.size();i++) {
				Data data=al.get(i);
				flag=insertTempStock(data);
				if(!flag) {
					break;
				}
				else {
					flag=updateFlagRecentActivity(billno,"true");
				}
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in openBillData() function "+e);
		}

		return flag;
	}

	public boolean insertTempStock(Data data) {
		boolean flag=false;
		try {
			ps=Data.con.prepareStatement("insert into tempstock values(?,?,?,?,?,?,?,?,?,?,?)");
			ps.setLong(1,data.billno);
			ps.setString(2,data.itemcode);
			ps.setString(3,data.purchaseid);
			ps.setString(4,data.categoryid);
			ps.setString(5,data.itemtype);
			ps.setString(6,data.color);
			ps.setInt(7,data.size);
			ps.setInt(8,data.quantity+data.currQuantity);
			ps.setInt(9,data.currQuantity);
			ps.setInt(10,data.price);
			ps.setInt(11,data.currPrice);
			int x=ps.executeUpdate();

			if(x>0)
			{	flag=true;

			}
			else
			{
				flag=false;
			}
		}
		catch(Exception e) {
			System.out.println("problem in insertTempStock() function "+e);
		}
		return flag;
	}


	public  boolean updateUsedFlagRecentActivity(long billno,String usedFlag)
	{     
		boolean flag=false;
		try
		{

			ps=Data.con.prepareStatement("update recentactivity set usedFlag=?");
			ps.setString(1,usedFlag);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;
			}
			else {
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in updateUsedFlagRecentActivity() function "+e);
		}
		return flag;
	}

	public  boolean updateFlagRecentActivity(long billno,String openFlag)
	{     
		boolean flag=false;
		try
		{

			ps=Data.con.prepareStatement("update recentactivity set openflag=?,tempbillno=?,Date=?");
			ps.setString(1,openFlag);
			ps.setLong(2,billno);
			long millis=System.currentTimeMillis();  
			java.sql.Date date=new java.sql.Date(millis);  
			ps.setDate(3,date);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;
			}
			else {
				flag=false;
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in updateFlagRecentActivity() function "+e);
		}
		return flag;
	}

	public int getTotalSale()
	{     
		int amount=0;
		int totalsale=0;
		try
		{

			ps=Data.con.prepareStatement("select amountpaid from purchasebilldetail");
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				amount=rs.getInt("amountpaid");
				totalsale=totalsale+amount;	 
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in getTotalSale() function "+e);
		}
		return totalsale;

	}

	public int getPurchaseRowCount()
	{     
		int count=0;

		try
		{

			ps=Data.con.prepareStatement("select * from purchasedata");
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				count=rs.getInt("sno");

			}

		}
		catch(Exception e)
		{
			System.out.println("problem in getPurchaseRowCount() function "+e);
		}
		return count;

	}

	public boolean deletePurchaseRow(int sno)
	{     
		boolean flag=false;

		try
		{

			ps=Data.con.prepareStatement("delete from purchasebook where sno=?");
			ps.setInt(1,sno);
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in deletePurchaseRow() function "+e);
		}
		return flag;

	}

	public boolean deletePurchaseData()
	{     
		boolean flag=false;

		try
		{

			ps=Data.con.prepareStatement("delete from purchasebook");
			int x=ps.executeUpdate();
			if(x>0) {
				flag=true;
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in deletePurchaseData() function "+e);
		}
		return flag;

	}

	public boolean checkPurchaseDataStatus() {
		boolean flag=false;

		try
		{

			ps=Data.con.prepareStatement("select * from recentactivity");
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				String vflag=rs.getString("voucherflag");
				if(vflag.equals("true")) {
					flag=true;
				}
				else {
					flag=false;
				}
			}

		}
		catch(Exception e)
		{
			System.out.println("problem in deletePurchaseData() function "+e);
		}
		return flag;
	}

	public boolean savePurchaseData(Data data)
	{     
		boolean flag=false;

		try
		{
			ps=Data.con.prepareStatement("insert into purchasedata select * from purchasebook where purchasebook.sno not in(select sno from purchasedata)");  


			int x =ps.executeUpdate();
			ps=Data.con.prepareStatement("delete from purchasedata where voucherno=? and purchasedata.sno not in(select sno from purchasebook)");  	
			ps.setLong(1, data.voucherno);
			int y =ps.executeUpdate();

			ps=Data.con.prepareStatement("update purchaseentry set lrdesc=?,lrno=?,lrdate=?,vat=?,fright=?,discount=?,grandtotal=? where voucherno=?");  	
			ps.setString(1,data.lrdesc);
			ps.setString(2,data.lrno);
			ps.setString(3,data.lrdate);
			ps.setInt(4,data.vat);
			ps.setInt(5,data.fright);
			ps.setInt(6,data.discount);
			ps.setInt(7,data.grandtotal);
			ps.setLong(8,data.voucherno);
			int z =ps.executeUpdate();


		}
		catch(Exception e)
		{
			System.out.println("problem in savePurchaseData() function "+e);
		}
		return flag;

	}

	public boolean openPurchaseData(long voucherno)
	{     
		boolean flag=false;

		try
		{
			ps=Data.con.prepareStatement("insert into purchasebook select * from purchasedata where voucherno=?");  
			ps.setLong(1, voucherno);

			int x =ps.executeUpdate();

			if(x>0) {
				ps=Data.con.prepareStatement("update recentactivity set voucheropenflag=?,tempvoucherno=?");  
				ps.setString(1,"true");
				ps.setLong(2,voucherno);
				int y=ps.executeUpdate();
				if(y>0) {
					flag=true;
				}
				else {
					flag=false;
				}
				
			}
		}
		catch(Exception e)
		{
			System.out.println("problem in openPurchaseData() function "+e);
		}
		return flag;

	}
}


