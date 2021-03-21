package classes;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Data;
import com.Database;

/**
 * Servlet implementation class AddItemServlet
 */
@WebServlet("/PurchaseBookServlet")
public class PurchaseBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseBookServlet() {
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
		Database db = new Database();

		boolean flag=false;
		String value=null;
		
		try {
			value=request.getParameter("submit");
			if(value!=null) {
				
				if(value.equals("clear")) {
					flag=db.checkPurchaseDataStatus();
					if(flag) {
						flag=db.deletePurchaseData();
						db.updateRecentActivityVoucher("false");
						db.updateRecentActivityVoucherNo();
					}
					else {
						flag=db.deletePurchaseData();
						db.updateRecentActivityOpenFlag();
					}
					
					response.sendRedirect("newpurchase.jsp");
				}
				
				else if(value.equals("save")) {
					Data data=new Data();
					data.voucherno=Long.parseLong(request.getParameter("voucherno"));
					data.lrdesc=request.getParameter("lrdesc");
					if(data.lrdesc==null || data.lrdesc.equals("")) {
						data.lrdesc="NA";
					}
					
					data.lrno=request.getParameter("lrno");
					if(data.lrno==null || data.lrno.equals("")) {
						data.lrno="NA";
					}
					data.lrdate=request.getParameter("lrdate");
					if(data.lrdate==null || data.lrdate.equals("")) {
						data.lrdate="NA";
					}
					data.vat=Integer.parseInt(request.getParameter("vat"));
					data.fright=Integer.parseInt(request.getParameter("fright"));
					data.discount=Integer.parseInt(request.getParameter("discount"));
					data.grandtotal=Integer.parseInt(request.getParameter("grandtotal"));
					System.out.println(data.voucherno);
					System.out.println(data.lrdate);
					System.out.println(data.lrno);
					flag=db.savePurchaseData(data);
					db.updateRecentActivityVoucher(data.voucherno);
					
					response.sendRedirect("newpurchase.jsp");
				}
				
				else if(value.equals("open")) {
					long voc=Long.parseLong(request.getParameter("voucherInput"));
					flag=db.openPurchaseData(voc);
					
					response.sendRedirect("newpurchase.jsp");
				}
			}
			else {

				
				int val=Integer.parseInt(request.getParameter("del"));
				if(val>0) {
					System.out.println("Delete Action");
					flag=db.deletePurchaseRow(val);
					response.sendRedirect("newpurchase.jsp");
				}
			}
		}
			catch(Exception e) {
				System.out.println("Hello");
			}

	}
}
