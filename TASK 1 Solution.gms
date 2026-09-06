
* Import data from Data1.xlsx
$call GDXXRW.EXE Data1.xlsx output=Data1.gdx par=s rng=Time!a9:ao10 cdim=1 rdim=0 par=a rng=Time!a1:ao2 cdim=1 rdim=0 par=b rng=Time!a5:ao6 cdim=1 rdim=0 par=d rng=Distance!a1:av42 dim=2
* Define the set of nodes
set v /0*40/;
alias(v, i, j);

* Declare parameters
parameter
d(i,j) Half-distance matrix,
a(i)  Start time window at node i,
b(i)  End time window at node i,
s(i)  Service time at node i,
t(i,j) Travel time between node i and node j
d_full(i,j) complete full symmetric Matrix;
 

* Average speed in km/h
scalar g Average speed /50/
M        Large_Number     /10000/;



$gdxIn Data1.gdx
$load d, a, b, s
$gdxIn

d_full(i,j) = d(i,j);
d_full(j,i)$(not d_full(j,i)) = d(i,j);
Display d_full, a, b, s  ;




t(i,j)=(d_full(i,j)/g)*60;

display t;

*Enter the variables here.
Binary Variable x(i,j)"1 if traveling from i to j, 0 otherwise";
 
Positive Variables
u(i)  "Position of node i in the tour"
z(i)   "Arrival time at node i"
;
Variable F;
equations
OF                    Distance minimization (objective function)
nb1(j)                every node has only one predecessor node
nb2(j)                every node has only one successor node
nb3(i,j)              Subtour elimination constraint
tw1(i)                Arrival time is within the time window
tw2(i)                Arrival time is within the time window
Time (i,j)            Arrival time calculation



;


*Enter OF, nb1(j) and nb2(j) and nb3(i,j) here.
OF.. F=e= sum((i,j), d_full(i,j) * x(i,j));

nb1(j)..  sum(i, x(i,j))=e= 1;

nb2(j)..  sum(i, x(j,i))=e= 1;

*ord is used to implement the position of an element in a set
*ord (i)> 1 means that the position of i is greater than 1
*->ord(i) starts at second positon of the set V -> node 2
*subtour_elimination(i,j)$(ord(i)>1 and ord(j)>1 and ord(i)<> ord(j)).. u(i) - u(j) + card(v) * x(i,j) =l= card(v) - 1;
nb3(i,j)$(ord(i)>1 and ord(j)>1 and ord(i)<> ord(j)).. u(i) - u(j) + (card(V)-1)*x(i,j) =L= card(V)-2 ;


tw1(i).. a(i)=L=z(i);
tw2(i).. z(i) =L= b(i);

Time(i,j)$(ord(i) > 1 and ord(j) > 1) ..z(i) + s(i) + t(i,j) - M * (1 - x(i,j)) =L= z(j);




  

option optcr = 0.0 ;

*Enter the model declaration and the solving instruction here.
Model TSP /all/;



* Solver options for debugging and performance 

Solve TSP minimizing F using MIP;


*Output all variable values.
Display F.L, x.L, u.L,z.L;

$exit;
