package algorithm;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * <p>
 * This Class get the calculated best path and display it on the web page.
 * </p>
 * 
 * @author Jiazhe Wang
 * @version 1.8
 * 
 */
public class GetPoints extends HttpServlet {

	private static final long serialVersionUID = 4548813393719269865L;

	public GetPoints() {
		super();
	}

	/**
	 * Initialization of the servlet.
	 * 
	 * @throws ServletException
	 *             if an error occurs
	 */
	@Override
	public void init() throws ServletException {
		super.init();
	}

	/**
	 * Destory of the servlet.
	 */
	@Override
	public void destroy() {
		super.destroy();
	}

	/**
	 * The doGet method of the servlet.
	 * 
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		HttpSession s = request.getSession();
		ArrayList<String> list = (ArrayList<String>) s.getAttribute("Barcode");

		if (list == null || list.size() == 1) {

		} else {
			// test
			// System.out.print(list.toString());
			// System.out.print("lalalala");

			StringBuilder builder = new StringBuilder();

			ControlAlgorithm generator = new ControlAlgorithm(list);

			Point[] bestPath = generator.generateBestPath();

			// Point[] books = generator.getBooks();
			// Now use isABook() to find books in bestPath

			// test
			// System.out.println("Path Informatino Received!");
			// System.out.println("************************************");
			// System.out.println("lenght=" + bestPath.length);
			// for (int i = 0; i < bestPath.length; i++) {
			// System.out.println("[" + bestPath[i].getX() + ", "
			// + bestPath[i].getY() + "]");
			// }
			// System.out.println("************************************");

			// test
			// System.out.println("Book Informatino Received!");
			// System.out.println("************************************");
			// System.out.println("lenght=" + books.length);
			// for(int i=0; i<books.length;i++){
			// System.out.println("[" + books[i].getX() + ", " + books[i].getY()
			// + "]");
			// }
			// System.out.println("************************************");
			// Point[] bestPath = generator.generateTestPath();

			ArrayList<String> strings = generateTabString(bestPath);// XXX

			builder.append("[");

			int i;
			for (i = 0; i < strings.size() - 1; i++) {
				builder.append("{\"string\":\"").append(strings.get(i))
						.append("\"},");
				// System.out.println(positions[i]);// XXX
			}
			builder.append("{\"string\":\"").append(strings.get(i))
					.append("\"}");
			// System.out.println(positions[i]);// XXX

			builder.append("]");

			response.setContentType("application/json");

			PrintWriter writer = response.getWriter();
			// System.out.println(builder.toString());
			writer.print(builder);
		}
	}

	private ArrayList<String> generateTabString(Point[] bestPath) {
		ArrayList<String> tabStrings = new ArrayList<String>();

		LineSegment lineSegmentArray[] = new LineSegment[bestPath.length];

		//
		Point p1 = new Point(200, 420);
		Point p2 = new Point(300, 420);

		LineSegment testline = new LineSegment(p1, p2);
		// System.out.println("*** Test the isCollidedWithShelf ***"+
		// testline.isCollidedWithShelf());
		//
		int i = 0;
		int j = 0;
		for (i = 0; i < bestPath.length - 1; i++) {
			LineSegment lineSegment;
			lineSegment = new LineSegment(bestPath[i], bestPath[i + 1]);
			lineSegmentArray[i] = lineSegment;

			String ul;

			String shiftString = "";

			for (int k = 0; k < i; k++) {
				if (lineSegment.isCollidedWith(lineSegmentArray[k])) {

					// System.out.println("\n=========  isCollided  =======\n");

					if (lineSegment.onShelfTop()) {
						shiftString = "data-shiftCoords='0,-1'";
						// System.out.println("\n-----data-shiftCoords='0,-1'----\n");
					} else if (lineSegment.onShelfBottom()) {
						shiftString = "data-shiftCoords='0, 1'";
						// System.out.println("\n-----data-shiftCoords='0, 1'----\n");
					} else if (lineSegment.onShelfLeft()) {
						shiftString = "data-shiftCoords='-1, 0'";
						// System.out.println("\n-----data-shiftCoords='-1,0'----\n");
					} else if (lineSegment.onShelfRight()) {
						shiftString = "data-shiftCoords='1, 0'";
						// System.out.println("\n-----data-shiftCoords='1,0'----\n");
					}

				}
			}// XXX

			String li;
			li = "<li data-coords='"
					+ lineSegmentArray[i].getHead().toTopCoordString() + "'>"
					+ "</li>";
			li += "<li data-coords='"
					+ lineSegmentArray[i].getTail().toTopCoordString() + "'>"
					+ "</li>";

			ul = "<ul data-color='" + lineSegment.colorString(j) + "' "
					+ shiftString + ">" + li + "</ul>";

			tabStrings.add(ul);

			if (bestPath[i + 1].isABook()) {
				j++;
			}
		}

		// mark books
		// int index = 1;
		String li = "";
		for (i = 0; i < bestPath.length - 1; i++) {
			if (bestPath[i].isABook()) {
				li += "<li data-coords='" + bestPath[i].toTopCoordString()
						+ "' data-marker='@interchange' data-labelPos='E'>"
						+ (bestPath[i].getIndex() + 1) + "</li>";
				// index++;
			}
		}

		String ul = "<ul data-color='#000000'>" + li + "</ul>";

		tabStrings.add(ul);

		return tabStrings;
	}

	/**
	 * The doPost method of the servlet.
	 * 
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
	}
}
