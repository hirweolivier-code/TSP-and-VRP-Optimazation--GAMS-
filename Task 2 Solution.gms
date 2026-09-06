* Import data from Data2.xlsx
$call GDXXRW.EXE Data2.xlsx output=Data2.gdx par=s rng=Time!a9:ao10 cdim=1 rdim=0 par=a rng=Time!a1:ao2 cdim=1 rdim=0 par=b rng=Time!a5:ao6 cdim=1 rdim=0 par=d rng=Distance!a1:av42 dim=2

*Enter sets here.
sets
   n /0, 1*20/ 
   k /1*3/;   

alias(n,i,j);  

*Enter parameters here.
parameter
   d(i,j)        Half-distance matrix,
   d_full(i,j)   Complete full symmetric matrix,
   a(i)           Start time window at node i,
   b(i)           End time window at node i,
   s(i)           Service time at node i,
   t(i,j)         Travel time between nodes;

$gdxIn Data2.gdx
$load d, a, b, s
$gdxIn

* Fill the full distance matrix (symmetric)
d_full(i,j) = d(i,j);
d_full(j,i)$(not d_full(j,i)) = d(i,j);

Display d_full, a, b, s;

t(i,j) = d_full(i,j);

display t;


scalar M /10000/;   

*Enter variables here.
binary variable x(i,j,k) is 1 if vehicle k drives directly from node i to node j (0 otherwise);
binary variable y(i,k) is 1 if node i is served by vehicle k (0 otherwise);
Positive variable
   u(i,k)   Position of node i in a tour for vehicle k,
   z(i)     Arrival time at node i;

Variable F Total distance (objective function value);

equation
   Of              Minimization of total distance (objective function),
   Cover(i)        Every customer is assigned to one vehicle,
   Capa(k)         The Limitation of customers per vehicle,
   Flow(i,k)       Flow preservation constraint,
   Couple(i,k)     Coupling constraint for the variables x and y,
   Subtour(i,j,k)  To avoid subtours,
   tw1(i)          Arrival time is within the time window,
   tw2(i)          Arrival time is within the time window,
   Time(i,j,k)     Arrival time calculation;

* Define the objective function to minimize total distance
Of.. 
   F =E= sum((i,j,k), d_full(i,j) * x(i,j,k));  

*You can further define the constraints and other parts of the model here as needed.

* Constraints and other parts of the model would be written below, e.g., 
* Cover, Flow, Capa, etc., based on your problem requirements.
                                       
Cover(i)$(ord(i) > 1)..                 sum(k, y(i,k)) =E= 1;


Capa(k)..                               sum(i, y(i,k)) =L= 8;


Flow(i,k)..                             sum(j, x(i,j,k)) =E= sum(j, x(j,i,k) );


Couple(i,k)..                           sum(j, x(j,i,k)) =E= y(i,k);


Subtour(i,j,k)$(ord(i) > 1 and ord(j) > 1)..        u(i,k) - u(j,k) +  card(i) * x(i,j,k) =l= card(i) - 1;

tw1 (i)..                              a(i)=L=z(i);
tw2(i)..                               z(i)=L=b(i);

Time(i,j,k) $ (ord(i)>1 and ord(j)>1 and ord (i)<> ord(j) )..z(i)+s(i)+t(i,j)-M*(1-x(i,j,k))=L=z(j);                       
*(absolute value of i) = card(i)

option optcr = 0.0 ;


model CVRP /all/ ;


*Fix x(i,j,k) to 0 when i == j (no self-loops)
x.fx(i,j,k)$(ord(i)=ord(j)) = 0;

* Solve the model using Mixed Integer Programming (MIP)
solve CVRP minimizing F using MIP;


* Display the results (solution values)
display x.L,u.L, y.L, z.L,  F.L;


*use mio usi



*Enter model declaration and solving instruction here.



*Output all variable values.







********************************************************
*****   TEXT FILE       ********************************
********************************************************
file out /Solution.txt/ ;

