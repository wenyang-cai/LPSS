package connectionWeb;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * <p>
 * This class handle the request of help JSP.
 * </p>
 * <p>
 * When the user clicks the link and down load the UserManual.pdf
 * </p>
 * 
 * @author Yiming Li
 * @version 1.8
 * 
 */
public class DownLoad extends HttpServlet {
	private static final long serialVersionUID = -1406488336873767088L;

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/pdf");
		response.setHeader("Content-Disposition",
				"attachment;filename=UserManual.pdf");
		
		// link to server and down load the UserManual.pdf
		File f = new File ("/Users/jiazhewang/Dev/EclipseWorkspace/LPSS/WebContent/pdf/UserManual.pdf");//XXX
		InputStream in = new FileInputStream(f);
		ServletOutputStream outs = response.getOutputStream();
		
		
		int bit = 256;
		try {
			while ((bit) >= 0) {
				bit = in.read();
				outs.write(bit);
			}
		} catch (IOException ioe) {
			ioe.printStackTrace(System.out);
		}
		outs.flush();
		outs.close();
		in.close();
	}
}
