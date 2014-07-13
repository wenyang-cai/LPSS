package algorithm;

import java.sql.*;
import java.util.ArrayList;
import util.MySQLConnection;

/**
 * The interface of the shortest path finding system It has the following four
 * responsibilities: 1. Access to the database and access data that required by
 * {@link AntColonyAlgorithm}, {@link GenericAlgorithm} and
 * {@link PathGenerator} 2. Transform the data format that suitable to the
 * interface of these classes 3. Invoke algorithm class
 * {@link AntColonyAlgorithm} and {@link GenericAlgorithm} to generate two
 * candidate (sub)optimal solutions 4. Invoke method
 * {@link PathGenerator#generatePath() generate path} in {@link PathGenerator}
 * class to generate a serious of inflection point on the map
 * 
 * @author Zhao Zhao Xueli Jia Date: 12/04/2012
 * @version 4.32
 */
public class ControlAlgorithm {
	/**
	 * The bar code information of each book that want to be borrowed These data
	 * are received from the request of web page server
	 */
	private ArrayList<String> barCode;
	/**
	 * {@link bookInformation book information} array list that used to store
	 * transformed book information
	 */
	private ArrayList<bookInformation> bi = new ArrayList<bookInformation>();

	private Point bestPath[];// Point array used to store inflection point
	private static final float SHELF_VERTICAL_SPACE = 20.0f; // shelf vertical space
	private static final float SHELF_HORIAONTAL_SPACE = 15.0f; // shelf horizontal space

	/**
	 * Constructor -- initialize the {@link ControlAlgorithm#barCode bar code}
	 * array list
	 * 
	 * @param b
	 */
	public ControlAlgorithm(ArrayList<String> b) {
		barCode = b;
	}

	/**
	 * Interface method that will be invoked by web page server It will invoke
	 * the support method {@link ControlAlgorithm#connectionMySQL
	 * connectionMySQL} to implement it function
	 * 
	 * @return inflection points on the map
	 */
	public Point[] generateBestPath() {
		connectionMySQL();
		return bestPath;
	}

	/**
	 * Support method for {@link ControlAlgorithm#generateBestPath()
	 * generateBestPath} It has the following three responsibilities: 1.
	 * Transform the data format that suitable to the interface of these classes
	 * 2. Invoke algorithm class {@link AntColonyAlgorithm} and
	 * {@link GenericAlgorithm} to generate two candidate (sub)optimal solutions
	 * 3. Invoke method {@link PathGenerator#generatePath() generate path} in
	 * {@link PathGenerator} class to generate a serious of inflection point on
	 * the map
	 */
	private void connectionMySQL() {
		for (int i = 0; i < barCode.size(); i++) {
			Connection con = MySQLConnection.connection();
			String title = null;
			String shelf = null;
			float x1 = 0.0f;
			float y1 = 0.0f;
			float x2 = 0.0f;
			float y2 = 0.0f;
			float x3 = 0.0f;
			float y3 = 0.0f;
			float x4 = 0.0f;
			float y4 = 0.0f;
			float x5 = 0.0f;
			float y5 = 0.0f;

			// access data from database and transform the data format that
			// suitable to the interface
			try {
				// select from book
				Statement state = con.createStatement();
				String query = "SELECT title,nameOfShelf FROM book WHERE barcode='"
						+ barCode.get(i) + "'";
				ResultSet rs = state.executeQuery(query);
				while (rs.next()) {
					title = rs.getString("title");
					shelf = rs.getString("nameOfShelf");
				}
				state.close();

				// select from title
				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),2)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x1 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT Y(PointN(ExteriorRing(location),2)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y1 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),3)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x2 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT Y(PointN(ExteriorRing(location),3)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y2 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),1)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x3 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT Y(PointN(ExteriorRing(location),1)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y3 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),4)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x4 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT Y(PointN(ExteriorRing(location),4)) FROM geom WHERE name='"
						+ shelf + "'";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y4 = rs.getFloat(1);
				}
				state.close();

				con.close();
			} catch (SQLException e) {
			}

			// calculate the book position according to its book title
			if (title.toLowerCase().charAt(0) <= 'f') {
				x5 = x1;
				y5 = 3 * (y1 - y3) / 4 + y3;
			} else if (title.toLowerCase().charAt(0) <= 'l') {
				x5 = x1;
				y5 = (y1 - y3) / 4 + y3;
			} else if (title.toLowerCase().charAt(0) <= 't') {
				x5 = x2;
				y5 = 3 * (y2 - y4) / 4 + y4;
			} else {
				x5 = x2;
				y5 = (y2 - y4) / 4 + y4;
			}

			// construct a new book information object according to the
			// transformed book information
			bookInformation B = new bookInformation(x5, y5, x1, y1, x2, y2, x3,
					y3, x4, y4);
			//set the index of the book
			B.getBookInformation().setIndex(i);
			// ass the book information instance into the book information list
			bi.add(B);
		}

		// translate these book information into a book information array
		bookInformation[] binf = new bookInformation[bi.size()];
		bi.toArray(binf);
		float[][] distanceMatrix = new float[bi.size()][bi.size()];

		// calculate the distance between each pair of books in the book
		// information list
		for (int i = 0; i < bi.size(); i++)
			for (int j = 0; j <= i; j++) {
				if (i == j)
					distanceMatrix[i][j] = 0;
				else {
					bookInformation[] tb = { binf[i], binf[j] };
					distanceMatrix[i][j] = distanceMatrix[j][i] = calcualteDistance(new PathGenerator(
							tb, SHELF_VERTICAL_SPACE, SHELF_HORIAONTAL_SPACE)
							.generatePath());
				}
			}

		// instance the two algorithms and invoke their drive method to generate
		// a (sub)optimal solution
		GenericAlgorithm ga = new GenericAlgorithm(binf.length, distanceMatrix);
		AntColonyAlgorithm ag = new AntColonyAlgorithm(binf.length,
				distanceMatrix);
		int[] orderOne = ga.drive();
		int[] orderTwo = ag.drive();
		/*
		 * rearrange the order of the book list according to the generated
		 * solution
		 */
		bookInformation[] solutionOne = new bookInformation[binf.length + 1];
		bookInformation[] solutionTwo = new bookInformation[binf.length + 1];
		for (int i = 0; i < binf.length; i++) {
			solutionOne[i] = binf[orderOne[i]];
			solutionOne[i].getBookInformation().setIndex(
					binf[orderOne[i]].getBookInformation().getIndex());
			solutionTwo[i] = binf[orderTwo[i]];
			solutionTwo[i].getBookInformation().setIndex(
					binf[orderTwo[i]].getBookInformation().getIndex());
		}
		solutionOne[binf.length] = binf[orderOne[0]];
		solutionOne[binf.length].getBookInformation().setIndex(
				binf[orderOne[0]].getBookInformation().getIndex());
		solutionTwo[binf.length] = binf[orderTwo[0]];
		solutionTwo[binf.length].getBookInformation().setIndex(
				binf[orderTwo[0]].getBookInformation().getIndex());
		// invoke path generator to generate inflection points on the map
		Point[] pathOne = new PathGenerator(solutionOne, SHELF_VERTICAL_SPACE,
				SHELF_HORIAONTAL_SPACE).generatePath();
		Point[] pathTwo = new PathGenerator(solutionTwo, SHELF_VERTICAL_SPACE,
				SHELF_HORIAONTAL_SPACE).generatePath();
		// choice the best solution from the two candidate solutions
		if (calcualteDistance(pathOne) < calcualteDistance(pathTwo))
			bestPath = pathOne;
		else
			bestPath = pathTwo;
	}

	/**
	 * Support method {@link ControlAlgorithm#connectionMySQL() connecttoMySQL}
	 * It has the responsibility to calculate the Manhattan distance between a
	 * serious of points
	 * 
	 * @param p
	 *            is the given serious of points that want to calculate the
	 *            Manhattan distance
	 * @return sum of calculated Manhattan distance
	 */
	private float calcualteDistance(Point[] p) {
		float sum = 0;
		for (int i = 0; i < p.length - 1; i++)
			sum += Math.abs(p[i].getX() - p[i + 1].getX())
					+ Math.abs(p[i].getY() - p[i + 1].getY());
		return sum;
	}
}