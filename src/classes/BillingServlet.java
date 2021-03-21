package classes;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Data;
import com.Database;

/**
 * Servlet implementation class BillingServlet
 */
@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BillingServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String minus[];
		String add[];
		Database db = new Database();
		Data obj=new Data();
		String itemcode = null;
		boolean addflag=false,flag=false;
		boolean flagA=false,flagB=false,flagC=false,flagD=false;
		String operation=null;
		try {

			operation=request.getParameter("submit");

			if(operation!=null) {
				obj.billno=Long.parseLong(request.getParameter("billno"));
				obj.itempurchased=Integer.parseInt(request.getParameter("itempurchased"));
				obj.totalprice=Integer.parseInt(request.getParameter("totalprice"));
				obj.discount=Integer.parseInt(request.getParameter("discount"));
				obj.discountamount=Integer.parseInt(request.getParameter("discountamount"));
				obj.adjustamount=Integer.parseInt(request.getParameter("adjustamount"));
				obj.amountpaid=Integer.parseInt(request.getParameter("amountpaid"));
				System.out.println("Amoutn Paid"+obj.amountpaid);
				if(operation.equals("Save")) {
					flagA=db.updatePurchaseBill(obj);
					System.out.println(flagA);
					System.out.println(obj.billno);
					if(flagA) {
						flagB=db.updateCustomerPurchase(obj.billno);
						db.deleteCustomerPurchaseWithNull(obj.billno);
					}
					if(flagB) {
						flagC=db.updateActualStock(obj.billno);
					}
					if(flagC) {
						flagD=db.updateRecentActivity(obj.billno);

					}


					if(flagA && flagB && flagC) {
						request.setAttribute("success","Bill Saved");			
					}

					else {
						request.setAttribute("failed","Bill Already Saved");
					}

					RequestDispatcher d = getServletContext().getRequestDispatcher("/test.jsp");
					d.forward(request, response);
				}
				else if(operation.equals("Clear")) {

					boolean nullData=db.checkTempStockWithNull(obj.billno);
					boolean noData=db.checkTempStockWithNoData(obj.billno);

					if(!noData && !nullData) {
						System.out.println("Data present in Temp Stock");
						flag=db.updateCustomerPurchase(obj.billno);
						flag=db.deleteCustomerPurchaseWithNull(obj.billno);
						flag=db.cleanNullPurchaseHistory(obj.billno);
						db.cleanTempStock(obj.billno);
						db.updateRecentActivityBill(obj.billno);
					}
					else if(noData || nullData){
						System.out.println("No Data or Null Data in Temp Stock");
						db.deletePurchaseBill(obj.billno);
						ArrayList<Data> al=db.getCustomerPurchase(obj.billno);
						db.deleteCustomerPurchase(obj.billno);
						db.updateActualStock(al);
						db.cleanTempStock(obj.billno);	
					}
					db.updateFlagRecentActivity(obj.billno, "false");
					db.updateUsedFlagRecentActivity(obj.billno,"false");
					RequestDispatcher d = getServletContext().getRequestDispatcher("/test.jsp");
					d.forward(request, response);					

				}
				else if(operation.equals("New")) {
					Data data=new Data();
					ArrayList<Data> al=db.getRecentActivity();
					data.flag=al.get(0).flag;
					data.billno=al.get(0).billno;
					if(al.get(0).flag.equals("true")) {
						db.deletePurchaseBill(data.billno);
						db.deleteCustomerPurchase(data.billno);

					}

					RequestDispatcher d = getServletContext().getRequestDispatcher("/test.jsp");
					d.forward(request, response);
				}

				else if(operation.equals("Print Bill")) {
					RequestDispatcher d = getServletContext().getRequestDispatcher("/Bill.jsp");
					d.forward(request, response);
				}

				else if(operation.equals("Open")) {
					try {
					obj.billno=Long.parseLong(request.getParameter("billInput"));
					flag=db.openBillData(obj.billno);
					if(!flag)
					request.setAttribute("billMsg","Bill Not Found");
					}
					catch(Exception e){
						request.setAttribute("billMsg","Bill Not Found");
					}
					RequestDispatcher d = getServletContext().getRequestDispatcher("/test.jsp");
					d.forward(request, response);
				}
			}
			else{
				try {
					minus=request.getParameterValues("minus");
					for(int i=0;i<minus.length;i++) {
						if(minus[i]!=null) {

							flag=db.minusTempStockQty(minus[i]);
							break;
						}
					}
				}
				catch(Exception e) {
				}
				try {
					add=request.getParameterValues("add");
					for(int i=0;i<add.length;i++) {
						System.out.println(add[i]);
						if(add[i]!=null) {
							addflag=db.addTempStockQty(add[i]);
							break;
						}
					}
				}
				catch(Exception e) {

				}


				if(!flag && !addflag) {
					obj.itemcode=(String)request.getParameter("itemcodebarcode");
					if(obj.itemcode!=null) {
						ArrayList<Data> al=db.getStock(obj.itemcode);
						if(al.size()>0 && al.get(0).quantity>0) {
							System.out.println(al.get(0).itemcode);
							flag=db.updateTempStock(al);
							request.getSession().setAttribute("flag",flag);		
							response.sendRedirect("test.jsp");
						}
						else {
							request.setAttribute("msg","No Item In Stock");	
							RequestDispatcher d = getServletContext().getRequestDispatcher("/test.jsp");
							d.forward(request, response);

						}
					}
					else {
						request.setAttribute("msg","No Item Found");

						RequestDispatcher d = getServletContext().getRequestDispatcher("/test.jsp");
						d.forward(request, response);

					}


				}
				else {
					if(!addflag) {
						request.setAttribute("msg","No Item In Stock");		
					}

					response.sendRedirect("test.jsp");
				}

			}
		}
		catch(Exception e) {

		}

	}



}
