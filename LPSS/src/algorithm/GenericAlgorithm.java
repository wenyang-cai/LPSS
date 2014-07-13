package algorithm;

import java.util.Random;

/**
 * The GeneticAlgorithm class implements an application that generate the order 
 * to get a sequence of books according to Manhattan distance
 * it uses Genetic algorithm to get these books in the shortest distance 
 * @author Xueli Jia, Zhao Zhao
 */
public class GenericAlgorithm {

	private int numOfBook;
	private float[][] distanceMatrix;

	/**
	 * this is the constructor of GenericAlgorithm class to initialize variables
	 * @param numOfBook store the number of books to search
	 * @param distanceMatrix store the distances between each two books
	 */
	public GenericAlgorithm(int numOfBook, float[][] distanceMatrix) {
		this.numOfBook = numOfBook;
		this.distanceMatrix = distanceMatrix;
	}

	/**
	 * The Gene class is an inner class to store the information of each gene
	 * it includes the fitness and the selected probability of the gene
	 * and an array which contains the elements of an gene
	 * @author Xueli Jia, Zhao Zhao
	 */
	private class Gene {
		public float fitness = 0;
		public float selectedProbability = 0;
		public int[] gene = new int[numOfBook];
	}

	/**
	 * The generator method is to generate a copy of gene so that called by other methods
	 * @param g store an instance of gene
	 * @return a copy of the gene
	 */
	private Gene generator(Gene g) {
		int[] temp = new int[numOfBook];
		for (int i = 0; i < numOfBook; i++)
			temp[i] = i;
		int w;
		Random rand = new Random();
		for (int i = 0; i < numOfBook; i++) {
			w = rand.nextInt(numOfBook - i) + i;
			int t = temp[i];
			temp[i] = temp[w];
			temp[w] = t;
			g.gene[i] = temp[i];
		}
		return g;
	}

	/**
	 * This method has ability to calculate the fitness of gene
	 * the fitness is equal to the sum of each two neighboring vertices of the gene
	 * @param g store an instance of Gene
	 * @return a gene with the changed fitness
	 */
	private Gene fitness(Gene g) {
		g.fitness = 0;
		for (int i = 0; i < numOfBook - 1; i++)
			g.fitness += distanceMatrix[g.gene[i]][g.gene[i + 1]];
		g.fitness += distanceMatrix[g.gene[numOfBook - 1]][g.gene[0]];
		return g;
	}

	/**
	 * This method has ability to calculate the selected probability of each gene
	 * the selected probability equals to the sum of all genes fitness minus this gene fitness
	 * @param g store an instance of Gene
	 * @return a gene with changed selected probability
	 */
	private Gene[] selectedProbability(Gene[] g) {
		int sum = 0;
		for (int i = 0; i < g.length; i++)
			sum += g[i].fitness;
		for (int i = 0; i < g.length; i++)
			g[i].selectedProbability = sum - g[i].fitness;
		return g;
	}

	/**
	 * This method implement the selection section of Generic algorithm
	 * it assumes that the selected probability of i gene is add 
	 * the selected probabilities from the first gene to the i gene.
	 * And then randomly select the same number of genes  
	 * @param g store an instance of Gene array
	 * @return a new gene pool with same number of genes as before
	 */
	private Gene[] selection(Gene[] g) {
		int sum = 0;
		Gene[] selectedGenePool = new Gene[g.length];
		int bestIndex = 0;
		for (int f = 0; f < g.length; f++) {
			if (g[f].selectedProbability > g[bestIndex].selectedProbability)
				bestIndex = f;
		}
		selectedGenePool[0] = new Gene();
		selectedGenePool[0].fitness = g[bestIndex].fitness;
		selectedGenePool[0].selectedProbability = g[bestIndex].selectedProbability;
		for (int i = 0; i < numOfBook; i++)
			selectedGenePool[0].gene[i] = g[bestIndex].gene[i];

		for (int i = 0; i < g.length; i++) {
			sum += g[i].selectedProbability;
			g[i].selectedProbability = sum;
		}

		Random rand = new Random();
		for (int i = 1; i < g.length; i++) {
			selectedGenePool[i] = new Gene();
			int r = 0;
			while ((r = rand.nextInt(sum)) == 0)
				;
			for (int j = 0; j < g.length - 1; j++) {
				if (r > g[j].selectedProbability
						&& r <= g[j + 1].selectedProbability) {
					selectedGenePool[i].fitness = g[j + 1].fitness;
					selectedGenePool[i].selectedProbability = g[j + 1].selectedProbability;
					for (int k = 0; k < numOfBook; k++)
						selectedGenePool[i].gene[k] = g[j + 1].gene[k];
					break;
				}
				if (r <= g[0].selectedProbability) {
					selectedGenePool[i].fitness = g[0].fitness;
					selectedGenePool[i].selectedProbability = g[0].selectedProbability;
					for (int k = 0; k < numOfBook; k++)
						selectedGenePool[i].gene[k] = g[0].gene[k];
					break;
				}
			}
		}
		return selectedGenePool;
	}

	/**
	 * This method execute the crossover section of Generic algorithm
	 * first there is a method to calculate constant pc,
	 * then generate a float r randomly, compare pc and r to decide whether 
	 * crossover or not.if not cross over, copy the original genes to new gene pool;
	 * else, after crossover, store the new genes to the new gene pool
	 * @param g store an instance of Gene array
	 * @return a new gene pool after crossover
	 */
	private Gene[] crossover(Gene[] g) {
		Gene[] childGenePool = new Gene[g.length];

		float minFit = g[0].fitness;
		for (int i = 1; i < g.length; i++)
			if (g[i].fitness < minFit)
				minFit = g[i].fitness;
		int sum = 0;
		for (int i = 0; i < g.length; i++)
			sum += g[i].fitness;
		float allFitAve = (float) sum / g.length;

		float pc = 0;
		float k = (float) 0.2;

		for (int i = 0; i < g.length; i += 2) {
			float parentsFitAve = ((float) g[i].fitness + g[i + 1].fitness) / 2;
			if (parentsFitAve > allFitAve)
				pc = k;
			else
				pc = k * ((parentsFitAve - minFit) / (allFitAve - minFit));

			Random rand = new Random();
			float r = 0;
			while ((r = rand.nextFloat()) == 1)
				;

			if (r > pc) {
				childGenePool[i] = new Gene();
				childGenePool[i + 1] = new Gene();
				childGenePool[i].fitness = g[i].fitness;
				childGenePool[i + 1].fitness = g[i + 1].fitness;
				childGenePool[i].selectedProbability = g[i].selectedProbability;
				childGenePool[i + 1].selectedProbability = g[i + 1].selectedProbability;
				for (int l = 0; l < numOfBook; l++) {
					childGenePool[i].gene[l] = g[i].gene[l];
					childGenePool[i + 1].gene[l] = g[i + 1].gene[l];
				}
				continue;
			}

			childGenePool[i] = new Gene();

			childGenePool[i].gene[0] = rand.nextInt(numOfBook - 1);
			int a = 0;
			for (; a < numOfBook; a++) {
				if (g[i].gene[a] == childGenePool[i].gene[0])
					break;
			}
			int b = 0;
			for (; b < numOfBook; b++) {
				if (g[i + 1].gene[b] == childGenePool[i].gene[0])
					break;
			}

			int[] cg1 = new int[numOfBook];
			int[] cg2 = new int[numOfBook];
			for (int d = 0; d < numOfBook; d++) {
				cg1[d] = g[i].gene[d];
				cg2[d] = g[i + 1].gene[d];
			}

			for (int c = 1; c < numOfBook; c++) {
				int p = 0, q = 0;
				for (p = a + 1;; p++) {
					if (p == a)
						p++;
					if (p == numOfBook)
						p = 0;
					if (cg1[p] != -1)
						break;
				}
				for (q = b + 1;; q++) {
					if (q == b)
						q++;
					if (q == numOfBook)
						q = 0;
					if (cg2[q] != -1)
						break;
				}
				if (distanceMatrix[cg1[a]][cg1[p]] <= distanceMatrix[cg2[b]][cg2[q]]) {
					childGenePool[i].gene[c] = cg1[p];
					cg1[a] = -1;
					cg2[b] = -1;
					a = p;
					for (b = 0; b < numOfBook; b++) {
						if (cg1[a] == cg2[b])
							break;
					}
				} else {
					childGenePool[i].gene[c] = cg2[q];
					cg1[a] = -1;
					cg2[b] = -1;
					b = q;
					for (a = 0; a < numOfBook; a++) {
						if (cg2[b] == cg1[a])
							break;
					}
				}
			}

			childGenePool[i + 1] = new Gene();

			childGenePool[i + 1].gene[0] = rand.nextInt(numOfBook - 1);
			a = 0;
			for (; a < numOfBook; a++) {
				if (g[i].gene[a] == childGenePool[i + 1].gene[0])
					break;
			}
			b = 0;
			for (; b < numOfBook; b++) {
				if (g[i + 1].gene[b] == childGenePool[i + 1].gene[0])
					break;
			}

			for (int d = 0; d < numOfBook; d++) {
				cg1[d] = g[i].gene[d];
				cg2[d] = g[i + 1].gene[d];
			}

			for (int c = 1; c < numOfBook; c++) {
				int p = 0, q = 0;
				for (p = a - 1;; p--) {
					if (p == a)
						p--;
					if (p == -1)
						p = numOfBook - 1;
					if (cg1[p] != -1)
						break;
				}
				for (q = b - 1;; q--) {
					if (q == b)
						q--;
					if (q == -1)
						q = numOfBook - 1;
					if (cg2[q] != -1)
						break;
				}

				if (distanceMatrix[cg1[a]][cg1[p]] <= distanceMatrix[cg2[b]][cg2[q]]) {
					childGenePool[i + 1].gene[c] = cg1[p];
					cg1[a] = -1;
					cg2[b] = -1;
					a = p;
					for (b = 0; b < numOfBook; b++) {
						if (cg1[a] == cg2[b])
							break;
					}
				} else {
					childGenePool[i + 1].gene[c] = cg2[q];
					cg1[a] = -1;
					cg2[b] = -1;
					b = q;
					for (a = 0; a < numOfBook; a++) {
						if (cg2[b] == cg1[a])
							break;
					}
				}
			}
		}
		return childGenePool;
	}

	/**
	 * This method execute the variation section of Generic algorithm
	 * there is conditions to decide whether do variation or not,
	 * only when satisfy the condition, it will do the variation,
	 * and store the new gene to the variation gene pool
	 * @param g store an instance of Gene array
	 * @return a new gene pool after variation
	 */
	private Gene[] variation(Gene[] g) {
		Gene[] variatGenePool = new Gene[g.length];

		float minFit = g[0].fitness;
		for (int i = 1; i < g.length; i++)
			if (g[i].fitness < minFit)
				minFit = g[i].fitness;
		int sum = 0;
		for (int i = 0; i < g.length; i++)
			sum += g[i].fitness;
		float allFitAve = (float) sum / g.length;

		float pm = 0;
		for (int i = 0; i < g.length; i++) {
			if (g[i].fitness < allFitAve)
				pm = (float) 0.05;
			else {
				pm = (float) 0.05
						* ((minFit - g[i].fitness) / (minFit - allFitAve));
			}
			Random rand = new Random();
			float r = rand.nextFloat();
			if (r > pm) {
				variatGenePool[i] = new Gene();
				variatGenePool[i].fitness = g[i].fitness;
				variatGenePool[i].selectedProbability = g[i].selectedProbability;
				for (int j = 0; j < numOfBook; j++)
					variatGenePool[i].gene[j] = g[i].gene[j];
				continue;
			}
			variatGenePool[i] = new Gene();
			int v1 = 0, v2 = 0;
			while ((v1 = rand.nextInt(numOfBook - 1)) == (v2 = rand
					.nextInt(numOfBook - 1)) && numOfBook>2)
				;
			int min = Math.min(v1, v2);
			int max = Math.max(v1, v2);
			for (int x = 0; x < min; x++) {
				variatGenePool[i].gene[x] = g[i].gene[x];
			}
			for (int y = max + 1; y < numOfBook; y++) {
				variatGenePool[i].gene[y] = g[i].gene[y];
			}
			for (int a = min, b = max; a <= max && b >= min; a++, b--) {
				variatGenePool[i].gene[a] = g[i].gene[b];
			}
		}
		return variatGenePool;
	}

	/**
	 * The dive method provides methods to determine the popSize,
	 * calculate the  generate times, and generate a gene pool.
	 * for each gene, it has three properties. 
	 * and after a fixed times of selection-crossover-variation,
	 * it get the final gene which maybe the shortest path to fetch books.
	 * Then get the best gene by comparing all these final genes.
	 * 
	 * @return best gene which is the shortest path to fetch these book
	 */
	public int[] drive() {
		int popSize = 0;
		if (numOfBook >= 25)
			popSize = numOfBook * (numOfBook - 1);
		else if(numOfBook >5 && numOfBook < 25){
			popSize = 500;
		}else{
			popSize = 1;
			for(int i=1; i<=numOfBook; i++)
				popSize *=i;
		}
		int generatTime = 0;
		if (numOfBook > 50)
			generatTime = 10 * numOfBook;
		else
			generatTime = 500;

		Gene[] genePool = new Gene[popSize];

		for (int k = 0; k < popSize; k++) {
			genePool[k] = new Gene();
			genePool[k] = generator(genePool[k]);
			genePool[k] = fitness(genePool[k]);
		}

		genePool = selectedProbability(genePool);

		for (int i = 0; i < generatTime; i++) {

			genePool = selection(genePool);

			genePool = selectedProbability(genePool);

			genePool = crossover(genePool);

			for (int h = 0; h < genePool.length; h++)
				genePool[h] = fitness(genePool[h]);
			genePool = selectedProbability(genePool);

			genePool = variation(genePool);

			for (int h = 0; h < genePool.length; h++)
				genePool[h] = fitness(genePool[h]);
			genePool = selectedProbability(genePool);
		}

		Gene bestGene = genePool[0];
		for (int f = 0; f < popSize; f++)
			if (genePool[f].fitness < bestGene.fitness)
				bestGene = genePool[f];
		return bestGene.gene;

	}
	
	public static void main(String args[]){
		Random rand = new Random();
		int n = 20;
		float[][] distanceMatrix = new float[n][n];
		for (int i = 0; i < n; i++)
			for (int j = 0; j < i; j++)
				distanceMatrix[i][j] = distanceMatrix[j][i] = rand.nextFloat()*49 + 51;

		for (int i = 0; i < n - 1; i++) {
			distanceMatrix[i][i] = 0;
			distanceMatrix[i][i + 1] = rand.nextFloat()*49 + 1;
			distanceMatrix[i + 1][i] = rand.nextFloat()*49 + 1;
		}

		distanceMatrix[n - 1][0] = distanceMatrix[0][n - 1] = rand.nextFloat()*49 + 1;
		distanceMatrix[n - 1][n - 1] = 0;
		
		GenericAlgorithm ga = new GenericAlgorithm(n, distanceMatrix);
		int[] solution = ga.drive();
		for(int i=0;i<n;i++)
			System.out.print(solution[i] + ", ");
	}
}
