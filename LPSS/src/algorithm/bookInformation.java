package algorithm;

/**
 * The bookInformation class has capability to store the information about books
 * and the shelf relate to that book.
 * 
 * @author Zhao Zhao
 * @author Xueli Jia
 * @version 1.8
 */
public class bookInformation {
	private Point bookPosition;
	private Point topLeftCorner;
	private Point topRightCorner;
	private Point buttonLeftCorner;
	private Point buttonRightCorner;

	/**
	 * This is the constructor of the class to initialize variables.
	 * 
	 * @param x1
	 *            store the X coordinate of book
	 * @param y1
	 *            store the Y coordinate of book
	 * @param x2
	 *            store X coordinate of the shelf top left vertex
	 * @param y2
	 *            store Y coordinate of the shelf top left vertex
	 * @param x3
	 *            store X coordinate of the shelf top right vertex
	 * @param y3
	 *            store Y coordinate of the shelf top right vertex
	 * @param x4
	 *            store X coordinate of the shelf button left vertex
	 * @param y4
	 *            store Y coordinate of the shelf button left vertex
	 * @param x5
	 *            store X coordinate of the shelf button right vertex
	 * @param y5
	 *            store y coordinate of the shelf button right vertex
	 */
	public bookInformation(float x1, float y1, float x2, float y2, float x3,
			float y3, float x4, float y4, float x5, float y5) {
		bookPosition = new Point(x1, y1);
		topLeftCorner = new Point(x2, y2);
		topRightCorner = new Point(x3, y3);
		buttonLeftCorner = new Point(x4, y4);
		buttonRightCorner = new Point(x5, y5);

	}

	/**
	 * This method is to get the position of the book.
	 * 
	 * @return book position in coordinate form
	 */
	public Point getBookInformation() {
		return bookPosition;
	}

	/**
	 * This method is to get the coordinate of top left corner of the bookshelf
	 * 
	 * @return book shelf top left corner position in coordinate form.
	 */
	public Point getTopLeftCorner() {
		return topLeftCorner;
	}

	/**
	 * This method is to get the coordinate of top right corner of the
	 * bookshelf.
	 * 
	 * @return book shelf top right corner position in coordinate form.
	 */
	public Point getTopRightCorner() {
		return topRightCorner;
	}

	/**
	 * This method is to get the coordinate of button left corner of the
	 * bookshelf.
	 * 
	 * @return book shelf button left corner position in coordinate form.
	 */
	public Point getButtonLeftCorner() {
		return buttonLeftCorner;
	}

	/**
	 * This method is to get the coordinate of button right corner of the
	 * bookshelf.
	 * 
	 * @return book shelf button right corner position in coordinate form.
	 */
	public Point getButtonRightCorner() {
		return buttonRightCorner;
	}

	/**
	 * This method is to estimate book position relate to the bookshelf, left or
	 * right .
	 * 
	 * @return -1 if book on the left side of bookshelf.
	 * @return 1 if book on the right side of bookshelf.
	 */
	public int leftOrRight() {
		if (bookPosition.getX() == getTopLeftCorner().getX())
			return -1;
		else
			return 1;
	}

	/**
	 * This method is to estimate book position relate to the bookshelf, up or
	 * down.
	 * 
	 * @return -2 if book on the up side of bookshelf.
	 * @return 1 if book on the down side of bookshelf.
	 */
	public int upOrDown() {
		if ((getTopLeftCorner().getY() - bookPosition.getY()) < ((float) (1 / 2) * (getTopLeftCorner()
				.getY() - getButtonLeftCorner().getY())))
			return -2;
		else
			return 2;
	}
}
