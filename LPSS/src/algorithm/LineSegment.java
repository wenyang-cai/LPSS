package algorithm;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import util.MySQLConnection;

public class LineSegment {
	private Point head;
	private Point tail;
	private String[] colorString = { "#ff0000", "#ff7f00", "#fbf200",
			"#bdfb00", "41fb00", "#00fbc9", "#00c9fb", "#0082fb", "003bfb",
			"#5e00fb", "#c300fb", "fb00b7" };

	public LineSegment(Point head, Point tail) {
		this.head = head;
		this.tail = tail;
	}

	public Point getHead() {
		return head;
	}

	public void setHead(Point head) {
		this.head = head;
	}

	public Point getTail() {
		return tail;
	}

	public void setTail(Point tail) {
		this.tail = tail;
	}

	public String colorString(int i) {
		return colorString[i%12];
	}

	public LineSegment translation(float dx, float dy) {
		Point newHead = new Point(this.getHead().getX() + dx, this.getHead()
				.getY() + dy);
		Point newTail = new Point(this.getTail().getX() + dx, this.getTail()
				.getY() + dy);
		LineSegment dl = new LineSegment(newHead, newTail);
		return dl;
	}

	public boolean isVertical() {
		return (this.getHead().getX() == this.getTail().getX());
	}

	public boolean isHorizontal() {
		return (this.getHead().getY() == this.getTail().getY());
	}

	public boolean isToUp() {
		return (this.isVertical() && this.getTail().getY() > this.getHead()
				.getY());
	}

	public boolean isToDown() {
		return (this.isVertical() && this.getTail().getY() < this.getHead()
				.getY());
	}

	public boolean isToLeft() {
		return (this.isHorizontal() && this.getTail().getX() < this.getHead()
				.getX());
	}

	public boolean isToRight() {
		return (this.isHorizontal() && this.getTail().getX() > this.getHead()
				.getX());
	}

	public LineSegment growForward(float d) {
		Point newHead = this.getHead();
		Point newTail = this.getTail();

		if (this.isToDown()) {
			newTail = newTail.addVector(0, -d);
		} else if (this.isToUp()) {
			newTail = newTail.addVector(0, d);
		} else if (this.isToLeft()) {
			newTail = newTail.addVector(-d, 0);
		} else if (this.isToRight()) {
			newTail = newTail.addVector(d, 0);
		}

		LineSegment nl = new LineSegment(newHead, newTail);
		return nl;
	}

	public LineSegment growBackward(float d) {
		Point newHead = this.getHead();
		Point newTail = this.getTail();

		if (this.isToDown()) {
			newHead = newHead.addVector(0, d);
		} else if (this.isToUp()) {
			newHead = newHead.addVector(0, -d);
		} else if (this.isToLeft()) {
			newHead = newHead.addVector(d, 0);
		} else if (this.isToRight()) {
			newHead = newHead.addVector(-d, 0);
		}

		LineSegment nl = new LineSegment(newHead, newTail);
		return nl;
	}

	public boolean onShelfTop() {
		return (this.translation(0, -10f).isCollidedWithShelf());
	}

	public boolean onShelfBottom() {
		return (this.translation(0, 10f).isCollidedWithShelf());
	}

	public boolean onShelfLeft() {
		return (this.translation(10f, 0).isCollidedWithShelf());
	}

	public boolean onShelfRight() {
		return (this.translation(-10f, 0).isCollidedWithShelf());
	}

	public boolean isCollidedWith(LineSegment other) {
		float x11 = this.getHead().getX();
		float x12 = this.getTail().getX();
		float x21 = other.getHead().getX();
		float x22 = other.getTail().getX();

		float y11 = this.getHead().getY();
		float y12 = this.getTail().getY();
		float y21 = other.getHead().getY();
		float y22 = other.getTail().getY();

		float temp;

		if (x11 > x12) {
			temp = x11;
			x11 = x12;
			x12 = temp;
		}

		if (x21 > x22) {
			temp = x21;
			x21 = x22;
			x22 = temp;
		}

		if (y11 > y12) {
			temp = y11;
			y11 = y12;
			y12 = temp;
		}

		if (y21 > y22) {
			temp = y21;
			y21 = y22;
			y22 = temp;
		}

		if (x11 == x12 && x12 == x21 && x21 == x22) {

			if (y22 > y12) {
				if (y21 < y12) {
					return true;
				} else {
					return false;
				}
			} else if (y22 == y12) {
				return true;
			} else {
				if (y11 < y22) {
					return true;
				} else {
					return false;
				}
			}

		} else if (y11 == y12 && y12 == y21 && y21 == y22) {

			if (x22 > x12) {
				if (x21 < x12) {
					return true;
				} else {
					return false;
				}
			} else if (x22 == x12) {
				return true;
			} else {
				if (x11 < x22) {
					return true;
				} else {
					return false;
				}
			}

		} else {
			return false;
		}

	}

	public boolean isCollidedWithShelf() {
		// one point in shelf
		if (this.getHead().isCollidedWithShelf()
				|| this.getTail().isCollidedWithShelf()) {
			return true;
		}

		Connection con = MySQLConnection.connection();
		String shelf = null;
		float x1 = 0.0f;
		float y1 = 0.0f;
		float x2 = 0.0f;
		float y2 = 0.0f;
		float x3 = 0.0f;
		float y3 = 0.0f;
		float x4 = 0.0f;
		float y4 = 0.0f;

		try {
			Statement state1 = con.createStatement();

			String query1 = "SELECT X(PointN(ExteriorRing(location),2)),name FROM geom;";
			ResultSet rs1 = state1.executeQuery(query1);
			while (rs1.next()) {
				x1 = rs1.getFloat(1);
				shelf = rs1.getString("name");

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
				query = "SELECT Y(PointN(ExteriorRing(location),3)) FROM geom WHERE name='"
						+ shelf + "';";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y2 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),1)) FROM geom WHERE name='"
						+ shelf + "';";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x3 = rs.getFloat(1);
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

				state = con.createStatement();
				query = "SELECT X(PointN(ExteriorRing(location),4)) FROM geom WHERE name='"
						+ shelf + "';";
				rs = state.executeQuery(query);
				while (rs.next()) {
					x4 = rs.getFloat(1);
				}
				state.close();

				state = con.createStatement();
				query = "SELECT Y(PointN(ExteriorRing(location),4)) FROM geom WHERE name='"
						+ shelf + "';";
				rs = state.executeQuery(query);
				while (rs.next()) {
					y4 = rs.getFloat(1);
				}
				state.close();

				// judge

				// y=y1
				if (this.getHead().getX() >= x1 && this.getHead().getX() <= x2) {
					if (this.getHead().getY() > this.getTail().getY()) {
						if (this.getHead().getY() >= y1
								&& this.getTail().getY() <= y1) {
							return true;
						}
					} else {
						if (this.getHead().getY() <= y1
								&& this.getTail().getY() >= y1) {
							return true;
						}
					}

				}

				// y=y3
				if (this.getHead().getX() >= x3 && this.getHead().getX() <= x4) {
					if (this.getHead().getY() > this.getTail().getY()) {
						if (this.getHead().getY() >= y3
								&& this.getTail().getY() <= y3) {
							return true;
						}
					} else {
						if (this.getHead().getY() <= y3
								&& this.getTail().getY() >= y3) {
							return true;
						}
					}

				}

				// x=x1
				if (this.getHead().getY() >= y3 && this.getHead().getY() <= y1) {
					if (this.getHead().getX() > this.getTail().getX()) {
						if (this.getHead().getX() >= x1
								&& this.getTail().getX() <= x1) {
							return true;
						}
					} else {
						if (this.getHead().getX() <= x1
								&& this.getTail().getX() >= x1) {
							return true;
						}
					}
				}

				// x=x3
				if (this.getHead().getY() >= y4 && this.getHead().getY() <= y2) {
					if (this.getHead().getX() > this.getTail().getX()) {
						if (this.getHead().getX() >= x2
								&& this.getTail().getX() <= x2) {
							return true;
						}
					} else {
						if (this.getHead().getX() <= x2
								&& this.getTail().getX() >= x2) {
							return true;
						}
					}
				}

			}
			state1.close();

			con.close();
		} catch (SQLException e) {

		}
		return false;
	}
}
