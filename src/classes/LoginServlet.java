package classes;

import com.*;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub


		Database db = new Database();
		Data obj=new Data();
		obj.login_id=request.getParameter("login_id");
		obj.login_password=request.getParameter("login_password");
		obj.user_type=request.getParameter("user_type");

		ArrayList<?> al=db.getLogin(obj);

		if(al.size()!=0)
		{
			Data data=(Data)al.get(0);
			if(data.user_type.equals("Administrator"))
			{
				request.getSession().setAttribute("msg","Welcome "+data.userName);
				RequestDispatcher d = getServletContext().getRequestDispatcher("/home.jsp");
				d.forward(request, response);
			}
			if(data.user_type.equals("Operator"))
			{
				RequestDispatcher d = getServletContext().getRequestDispatcher("/operatorhome.jsp");
				d.forward(request, response);

			}
		}
		else
		{
			request.setAttribute("msg","Invalid Login Id & Password");
			RequestDispatcher d = getServletContext().getRequestDispatcher("/index.jsp");
			d.forward(request, response);

		}


	}

}
