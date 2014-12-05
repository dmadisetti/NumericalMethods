Team F-Bomb’s Curve Fitting and Integration GUI a.k.a. GUI
By Dylan Madisetti, Logan Woot, Riley Knight, Rachael Rudd, Caleb Puppo, Jay Guerrero

	The GUI is an advanced interface that allows a user to fit data to a curve line formed from a polynomial. This polynomial is calculated in the MATLAB code that allowed us to create the F-GUI. The GUI also allows us to integrate the polynomial using three unique integration methods: 
		- Trapezoidal
		- 1/3 Simpson
		- 3/8 Simpson. 
	To run the GUI, run the CurveFitting.m file. Running the CurveFitting.fig file directly can occassionally cause problems. The GUI is operated by selecting an Excel sheet of data from the browse button. After selecting a file, you choose an order of polynomial for the plot to display. This visual will show how higher orders of polynomials will better fit a set of data. The three unique integration methods will calculate the area of the set of data that is displayed on the plot.

    See the attached screenshot.jpg for example of the program.

    It should be noted that with curve fits of high degree order (around 8 or 7 depending on data size), Matlab loses precision and will no longer produce an accurate plot.

    Use `Sample.xlsx` for sample data. Any other data used should consist of 2 columns of X,Y in the repective columns of A,B
