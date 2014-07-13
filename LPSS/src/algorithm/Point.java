package algorithm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.MySQLConnection;

/**
 * The Point class define a point which contains two elements and this class can
 * be called by PathGeneratoe class to provide points.
 * 
 * @author Xueli Jia
 * @author Zhao Zhao
 * @version 1.8
 */
public class Point {
	private float x;
	private float y;
	private boolean book;
	private int index;

	/**
	 * this is the constructor of the class to initialize variables
	 * 
	 * @param x
	 *            store the first element of point
	 * @param y
	 *            store the second element of point
	 */
	public Point(float x, float y) {
		this.x = x;
		this.y = y;
		book = false;
		index = -1;
	}

	/**
	 * Set the point as the index in book list precondition: the instance of
	 * this class is a book point.
	 * 
	 * @param i
	 *            the index value
	 */
	public void setIndex(int i) {
		index = i;
	}

	/**
	 * get the index value of this book point in the book list
	 * 
	 * @return index value
	 */
	public int getIndex() {
		return index;
	}

	/**
	 * This method is to set the point as a book
	 */
	public void setAsBook() {
		book = true;
	}

	/**
	 * This method is to estimate whether a point is a book or not if book
	 * equals to true, it is a book; else, it is not a book.
	 * 
	 * @return the state of book
	 */
	public boolean isABook() {
		return book;
	}

	/**
	 * this method has ability to get the first element of point
	 * 
	 * @return the first element of point
	 */
	public float getX() {
		return x;
	}

	/**
	 * this method has ability to get the second element of point
	 * 
	 * @return the second element of point
	 */
	public float getY() {
		return y;
	}
	public String toString() {
		return x + "," + y;
	}
	
	public String toTopCoordString(){
		return x + "," + (500 - y);
	}

	public boolean isPoint(Point p) {
		return ((p.getX() == this.x) && (p.getY() == this.y));
	}

	public Point addVector(float dx, float dy){
		Point newPoint = new Point(this.getX()+dx, this.getY()+dy);
		return newPoint;
	}
	
	public boolean isCollidedWithShelf() {
		Connection con = MySQLConnection.connection();
		String shelf = null;
		float x1 = 0.0f;
		float y1 = 0.0f;
		float x2 = 0.0f;
		float y3 = 0.0f;

		try {
			Statement state1 = con.createStatement();

			String query1 = "SELECT X(PointN(ExteriorRing(location),2)),shelf FROM geom;";
			ResultSet rs1 = state1.executeQuery(query1);
			while (rs1.next()) {
				x1 = rs1.getFloat(1);
				shelf = rs1.getString("shelf");

				Statement state = con.createStatement();
				String query = "SELECT Y(PointN(ExteriorRing(location),2)) FROM geom WHERE name='"
						+ shelf + "';";
				ResultSet rs = state.executeQuery(query);
				while (rs.next()) {
					y1 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),3)) FROM geom WHERE name='"
						+ shelf + "';";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x2 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT Y(PointN(ExteriorRing(location),1)) FROM geom WHERE name='"
						+ shelf + "';";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y3 = rs.getFloat(1);
				}
				state.close();

				// judge
				if (this.getX() >= x1 && this.getX() <= x2 && this.getY() >= y3
						&& this.getY() <= y1) {
					return true;
				}
			}
			state1.close();

			con.close();
		} catch (SQLException e) {

		}
		return false;
	}
}
