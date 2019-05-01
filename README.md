# Clingo
My Research

The program is based on all text files that can be run directly in a terminal.
System Requirements
OS: Ubuntu 16.04 version
	64 bit
Software Requirements
	clingo version 5.2.1
	SWI-Prolog
	Python 2.7.12





The structural format for program is based on two user agents.
One is a seller program and the other is a buyer program.
The functionality of the program requires us to run both the agents separately in two different terminals at the same time.
For the seller agent, we have files 'seller.lp' and 'selnew.lp'.
For the buyer agent, we have files 'buyer.lp' and 'buynew.lp'.
Both the agent programs need to follow some common rules that are saved in the 'rules.lp'.
To start running the program, let us start with the seller agent first.
	To run a seller agent, we need to open a new terminal and go to the directory where all the Negotiation project files are stored.
	Then run the command : clingo seller.lp selnew.lp rules.lp
	This will open up the terminal ready with seller agent.
	Now, lets run the buyer agent. For that we need to open another terminal go to the directory where all the Negotiation project files are stored.
	Then run the command : clingo buyer.lp buynew.lp rules.lp
	This will open up the terminal ready with buyer agent.

There is a format created to insert inputs to both the agents.
For a seller agent,
	Generally buyer's requirements are given as input into the seller agent.
	Format: {Goal}, {Buyer's knowledge about seller}, {buyer information}
	Example: {price}, {product_type, maker, quality}, {buyer information}
		Here, price can be 'high_price'/'low_price'/'lowest_price'.
		product_type can be 'product_A'/'product_B'
		maker can be 'maker_C'/'maker_D'
		quality / -quality
		and the buyer information can include 'student'/ 'senior' / 'cash' / 'bargain'
		
For a buyer agent,
	Seller's requirements/responses are given as input into the buyer agent.
	Format: {Goal}, {Seller's knowledge about buyer}, {seller information}
	Example: {price}, {buyer information}, {product_type, maker, quality}
	
Once any of the agent agrees upon the other agent's response, then the goal is achieved.
Key things to note here is to follow the format of inserting the input to both the agents.
A negotiation can start with one goal and it can vary during the negotiation and end up with a different goal.
