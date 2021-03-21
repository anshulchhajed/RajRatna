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
 * Servlet implementation class AddDealerServlet
 */
@WebServlet("/AddDealerServlet")
public class AddDealerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddDealerServlet() {
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
		boolean flag=false;
		Database db = new Database();
		Data obj=new Data();
		obj.companyName=(String)request.getParameter("company_name");
		obj.contact=Long.parseLong(request.getParameter("contact"));
		obj.address=(String)request.getParameter("address");
		obj.accountNo=Long.parseLong(request.getParameter("account_no"));
		obj.bankName=(String)request.getParameter("bank_name");
		obj.ifcsCode=(String)request.getParameter("ifsc");
		String val=request.getParameter("submit");
		if(val.equals("add")) {
			flag=db.insertDealer(obj);
			if(flag) {

				request.setAttribute("success","Dealer Information Saved");	
			}
			else {
				request.setAttribute("failed","Dealer Information Already Present");	

			}
		}

		if(val.equals("update")) {
			flag=db.updateDealer(obj);
			if(flag) {

				request.setAttribute("success","Dealer Information Saved");	
			}
			else {
				request.setAttribute("failed","Dealer Information Already Present");	

			}
		}

		if(val.equals("delete")) {
			flag=db.deleteDealer(obj);
			if(flag) {

				request.setAttribute("success","Dealer Information Saved");	
			}
			else {
				request.setAttribute("failed","Dealer Information Already Present");	

			}
		}

		RequestDispatcher d = getServletContext().getRequestDispatcher("/AddDealer.jsp");
		d.forward(request, response);

	}



}

