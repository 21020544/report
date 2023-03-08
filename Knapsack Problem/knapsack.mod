/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Hello
 * Creation Date: Feb 18, 2023 at 2:48:41 PM
 *********************************************/
int n = ...;
int m = ...;
int p[1..n] = ...;
dvar boolean x[1..n];
int r[1..m][1..n]=...;
int b[1..m] = ...;


dexpr int res = sum(j in 1..n) p[j]*x[j] ;
maximize res;
subject to {
  forall(i in 1..m) {
  	sum(j in 1..n) r[i][j]*x[j] <= b[i];}

  	sum(j in 1..n) x[j] >= n+1;
  
}

execute {
  writeln(res);
}