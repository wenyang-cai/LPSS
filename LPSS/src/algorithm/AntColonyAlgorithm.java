package algorithm;

import java.util.Random;

/**
 * <p>
 * This class implement Algorithm: Ant Colony Algorithm.
 * </p>
 * 
 * <p>
 * This algorithm simulate the behavior of ant colony when they find food and
 * search for a shortest path to get the food. In a higher abstract level, this
 * algorithm trying to solve the CTSP (classic traveling sales man problem),
 * which known as an NP-hard problem, and give an (sub)optimal solution to this
 * problem.
 * </p>
 * 
 * <p>
 * In particular, this algorithm will give the optimal fetch sequence of a book
 * list when a borrower want to find some books in a library. This algorithm is
 * also viewed as an component of the shortest path finding system. The latter
 * one is known as a service subsystem of the library management system. The
 * computation result of the object of this class will be used by
 * {@link ControlAlgorithm#generateBestPath() generatrBestPath} in class
 * {@link ControlAlgorithm ControalAlgorithm}, the latter one will invoke
 * {@link PathGenerator#generatePath() generatePath} in class
 * {@link PathGenerator PathGenerator} to generate the best path to fetch all
 * the books on the book-list.
 * </p>
 * 
 * @author Zhao Zhao
 * @author Xueli Jia
 * @version 1.8 Date: 12/04/2012
 * 
 */
public class AntColonyAlgorithm {
	/**
	 * Number of books that that the user want to borrow.
	 */
	private int numOfBook = 0;

	/**
	 * The population size of ant colony.
	 */
	private int popSize = 0;

	/**
	 * The ant list that reference to every ant in the ant colony.
	 */
	private ant[] antList;

	/**
	 * Reference to every edge object in the complete connected graph.
	 */
	private edge[][] edgeMatrix;

	/**
	 * Instance a random number generator.
	 */
	private static Random rand = new Random();

	/**
	 * <p>
	 * Inner class -- ant
	 * </p>
	 * 
	 * <p>
	 * Every instance of this class is viewed as an virtual ant It has the
	 * responsibility to record five predefined data records:
	 * <ul>
	 * <li>1. {@link ant#removableList removeableList}: this is the vertices
	 * list that the ant is permitted to go.</li>
	 * <li>2. {@link ant#tabuList tabeList}: this is the vertices list that the
	 * ant is not permitted to go.</li>
	 * <li>3. {@link ant#index index}: this is the pointer point to end of the
	 * {@link ant#tabuList tabuList}.</li>
	 * <li>4. {@link ant#candidateCost candidateCost} this is the total cost
	 * when the traveling according to the {@link ant#tabuList tabuList}.</li>
	 * <li>5. {@link ant#currentPosition cutrrentPosition} indicate the current
	 * position of this ant.</li>
	 * </ul>
	 * </p>
	 * 
	 * @author Zhao Zhao
	 * @author Xueli Jia
	 * @version 1.8 Date: 12/04/2012
	 * 
	 */
	private class ant {
		/**
		 * This is the vertices list that the ant is permitted to go.
		 */
		public int[] removableList;
		/**
		 * This is the vertices list that the ant is not permitted to go.
		 */
		public int[] tabuList;
		/**
		 * This is the pointer point to end of the {@link ant#tabuList tabuList}
		 * .
		 */
		public int index;
		/**
		 * This is the total cost when the traveling according to the
		 * {@link ant#tabuList tabuList}.
		 */
		public int candidateCost;
		/**
		 * Indicate the current position of this ant.
		 */
		public int currentPosition;

		/**
		 * Constructor -- initialize each data recored as a predefined value.
		 */
		public ant() {
			// initialize candidate coat as zero
			candidateCost = 0;
			// initialize current position as minus one
			currentPosition = -1;
			// initialize index as zero
			index = 0;
			// construct a removable list
			removableList = new int[numOfBook];
			// construct a tabu list
			tabuList = new int[numOfBook];

			// initialize each list
			for (int i = 0; i < numOfBook; i++) {
				removableList[i] = i;
				tabuList[i] = -1;
			}
		}
	}

	/**
	 * <p>
	 * Inner class -- edge.
	 * </p>
	 * 
	 * <p>
	 * Every instance of this class is an edge in the connected complete graph
	 * It has the responsibility to record three predefined data records:
	 * <ul>
	 * <li>1. {@link edge#pheromoneDensity pheromoneDesity}: record the
	 * pheromone desity on this edge.</li>
	 * <li>2. {@link edge#antList antList}: record the {@link ant} reference
	 * list that had ever pass this edge.</li>
	 * <li>3. {@link edge#length length}: record the length of this edge.</li>
	 * </ul>
	 * </p>
	 * 
	 * @author Zhao Zhao
	 * @author Xueli Jia
	 * @version 1.8 Date: 12/04/2012
	 * 
	 */
	private class edge {
		/**
		 * Record the pheromone desity on this edge.
		 */
		public float pheromoneDensity;

		/**
		 * Record the {@link ant} reference list that had ever pass this edge.
		 */
		public int[] antList;

		/**
		 * Record the length of this edge.
		 */
		public float length;

		/**
		 * Constructor -- initialize each data recored as a predefined value.
		 */
		public edge() {
			// Initially, the pheromone density of each is set a 5
			pheromoneDensity = 5;
			// construct an ant list
			antList = new int[popSize];
			// Initialize the edge length as ZERO
			length = 0;

			// Initialize the ant list
			for (int i = 0; i < popSize; i++) {
				antList[i] = -1;
			}
		}
	}

	/**
	 * Constructor -- initialize each data recored as a predefined value.
	 * 
	 * @param numOfBook
	 *            the number of books
	 * @param distanceMatrix
	 *            the distance matrix which record {@link edge edge} information
	 *            of every pair of vertices.
	 */
	public AntColonyAlgorithm(int numOfBook, float[][] distanceMatrix) {
		this.numOfBook = numOfBook;
		normalizeAntList();
		normalizeEdgeMatrix(distanceMatrix);
	}

	/**
	 * Normalize the ant list: construct an ant ant put it on the random choose
	 * vertex.
	 */
	private void normalizeAntList() {
		// initialize the population size
		if (numOfBook < 20)
			popSize = 10;
		else
			popSize = (int) (0.5 * numOfBook);

		// Construct an ant list
		antList = new ant[popSize];
		for (int i = 0; i < popSize; i++) {
			// construct an new ant
			antList[i] = new ant();
			// put the ant on a random choose vertex
			antList[i].currentPosition = rand.nextInt(numOfBook - 1);
			// remove the chosen vertex from removable list
			antList[i].removableList[antList[i].currentPosition] = -1;
			// add the chose vertex into the tabuList
			antList[i].tabuList[antList[i].index++] = antList[i].currentPosition;
		}
	}

	/**
	 * Normalize the edge matrix: construct an edge matrix.
	 * 
	 * @param distanceMatrixs
	 *            recored the distance of each pair of vertices This parameter
	 *            is used to initialize {@link edge#length length} of
	 *            {@link edge edge} object.
	 */
	private void normalizeEdgeMatrix(float[][] distanceMatrix) {
		// construct a edge matrix
		edgeMatrix = new edge[numOfBook][numOfBook];

		// initialize the edge matrix
		for (int i = 0; i < numOfBook; i++) {
			for (int j = 0; j < i; j++) {
				edgeMatrix[i][i] = new edge();
				edgeMatrix[i][j] = edgeMatrix[j][i] = new edge();
				edgeMatrix[i][j].length = edgeMatrix[j][i].length = distanceMatrix[i][j];
			}
		}
	}

	/**
	 * Normalize the {@link edge#antList antList} of each {@link edge} in
	 * {@link AntColonyAlgorithm#edgeMatrix edge matrix}.
	 */
	private void normalizeAntListInEdgeMatrix() {
		for (int i = 0; i < numOfBook; i++)
			for (int j = 0; j < i; j++)
				for (int k = 0; k < popSize; k++)
					edgeMatrix[i][j].antList[k] = -1;
	}

	/**
	 * Inner class -- point: A component class that is used to construct a
	 * linked list.
	 * 
	 * @author Zhao Zhao
	 * @author Xueli Jia
	 * @version 1.8 Date: 12/04/2012
	 */
	private class point {
		public int point1;
		public float point2;
		public point next;

		public point(int a, float b) {
			point1 = a;
			point2 = b;
		}
	}

	/**
	 * The basic simulation process of the behavior of one {@link ant ant} that
	 * a ant always has a higher probability to choice the {@link edge edge}
	 * which has higher {@link edge#pheromoneDensity pheromone desity}.
	 * 
	 * @param a
	 *            reference to an an instance
	 * @param n
	 *            is the identifier
	 * @return the ant instance which records has been modified
	 */
	private ant selecteEdge(ant a, int n) {
		// initialize the number of available vertices number as ZERO
		int avaliableVertexNumber = 0;

		// construct a linked list that used to reference to the available
		// vertices.
		point avaliableVertex = null;

		for (int i = 0; i < numOfBook; i++)
			if (a.removableList[i] != -1) {
				point p = new point(
						i,
						(float) (edgeMatrix[a.currentPosition][i].pheromoneDensity * Math
								.pow(((float) 1 / edgeMatrix[a.currentPosition][i].length),
										5)));
				p.next = avaliableVertex;
				avaliableVertex = p;
				avaliableVertexNumber++;
			}

		// calculate the accumulated sum of candidate cost of each available
		// vertex.
		float sum = 0;
		point p = avaliableVertex;
		for (int i = 0; i < avaliableVertexNumber; i++) {
			sum += p.point2;
			p = p.next;
		}

		// calculate the selection probability of each available vertex
		p = avaliableVertex;
		float sum1 = 0;
		for (int i = 0; i < avaliableVertexNumber; i++) {
			sum1 += (p.point2 / sum);
			p.point2 = sum1;
			p = p.next;
		}

		// use Roulette model to select an edge for the given ant
		float RandselecteVertex = 0;
		while ((RandselecteVertex = rand.nextFloat() * sum1) == 0)
			;

		p = avaliableVertex;
		for (int i = 1; i < avaliableVertexNumber; i++) {
			if (RandselecteVertex > p.point2
					&& RandselecteVertex <= p.next.point2) {
				a.removableList[p.next.point1] = -1;
				a.tabuList[a.index++] = p.next.point1;
				edgeMatrix[a.currentPosition][p.next.point1].antList[n] = n;
				a.currentPosition = p.next.point1;
				return a;
			}
			p = p.next;
		}

		a.removableList[avaliableVertex.point1] = -1;
		a.tabuList[a.index++] = avaliableVertex.point1;
		edgeMatrix[a.currentPosition][avaliableVertex.point1].antList[n] = n;
		a.currentPosition = avaliableVertex.point1;

		return a;
	}

	/**
	 * Calculate the candidate cost of an {@link ant ant}.
	 * 
	 * @param a
	 *            reference to a given {@link ant}
	 * @return the ant instance which records has been modified
	 */
	private ant candidateCost(ant a) {
		a.candidateCost = 0;
		for (int i = 0; i < numOfBook - 1; i++) {
			try {
				a.candidateCost += edgeMatrix[a.tabuList[i]][a.tabuList[i + 1]].length;
			} catch (ArrayIndexOutOfBoundsException e) {
				e.getMessage();
				System.out.println("Number of books = " + numOfBook);
				System.out
						.println("Ant tabulist length = " + a.tabuList.length);
				System.out.println("edgeMatrix[" + edgeMatrix.length + "] ["
						+ edgeMatrix[i].length + "]");
				System.out.println("Source point: " + a.tabuList[i]);
				System.out.println("Target point: " + a.tabuList[i + 1]);
			}
		}
		a.candidateCost += edgeMatrix[a.tabuList[numOfBook - 1]][a.tabuList[0]].length;
		return a;
	}

	/**
	 * Another basic simulation process that implement the
	 * {@link AntColonyAlgorithm ant colony algorithm}.
	 * 
	 * This method will be invoked when the {@link ant#removableList
	 * removableList} of each {@link ant ant} in
	 * {@link AntColonyAlgorithm#antList ant list} is empty.
	 */
	private void updatePheromoneMatrix() {
		for (int i = 0; i < numOfBook; i++) {
			for (int j = 0; j < i; j++) {
				float pheromoneSum = 0;
				for (int k = 0; k < popSize; k++) {
					float pheromoneDif = 0;
					if (edgeMatrix[i][j].antList[k] != -1)
						pheromoneDif = (float) 100 / antList[k].candidateCost;
					pheromoneSum += pheromoneDif;
				}
				edgeMatrix[i][j].pheromoneDensity = (float) (0.7 * edgeMatrix[i][j].pheromoneDensity + pheromoneSum);
			}
		}
	}

	/**
	 * Drive method which will be invoked by {@link ControlAlgorithm
	 * ControlAlgorithm}.
	 * 
	 * It has the responsibility to control whole process simulation process.
	 * 
	 * @return A (sub)optimal solution to the CTSP (classic traveling sales man
	 *         problem)
	 */
	public int[] drive() {
		ant bestAnt = new ant();
		bestAnt.candidateCost = 1000000;
		for (int i = 0; i < popSize; i++) {
			for (int j = 0; j < popSize; j++) {
				for (int k = 1; k < numOfBook; k++) {
					antList[j] = selecteEdge(antList[j], j);
				}
				antList[j] = candidateCost(antList[j]);
				if (antList[j].candidateCost < bestAnt.candidateCost) {

					bestAnt.candidateCost = antList[j].candidateCost;
					for (int m = 0; m < numOfBook; m++) {
						bestAnt.tabuList[m] = antList[j].tabuList[m];
					}
				}
			}
			updatePheromoneMatrix();
			normalizeAntList();
			normalizeAntListInEdgeMatrix();

		}
		return bestAnt.tabuList;
	}

	/**
	 * main for testing.
	 * 
	 * @param arg
	 */
	public static void main(String arg[]) {
		int n = 50;
		float[][] distanceMatrix = new float[n][n];
		for (int i = 0; i < n; i++)
			for (int j = 0; j < i; j++)
				distanceMatrix[i][j] = distanceMatrix[j][i] = rand.nextFloat() * 49 + 51;

		for (int i = 0; i < n - 1; i++) {
			distanceMatrix[i][i] = 0;
			distanceMatrix[i][i + 1] = rand.nextFloat() * 49 + 1;
			distanceMatrix[i + 1][i] = rand.nextFloat() * 49 + 1;
		}

		distanceMatrix[n - 1][0] = distanceMatrix[0][n - 1] = rand.nextFloat() * 49 + 1;
		distanceMatrix[n - 1][n - 1] = 0;

		AntColonyAlgorithm ac = new AntColonyAlgorithm(n, distanceMatrix);

		int[] solution = ac.drive();

		for (int i = 0; i < n; i++)
			System.out.print(solution[i] + ", ");
	}
}
