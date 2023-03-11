/*********************************************
 * OPL 22.1.0.0 Model
 * Author: Hello
 * Creation Date: Mar 6, 2023 at 11:02:58 PM
 *********************************************/
int n = ...;
int m = ...;
int p[1..n] = ...;
int T = ...; 
int B = ...;
int q[1..n] = ...;
tuple c {
   int _i;
   int _j;
};
c C[1..2] = ...;

range J = 1..n;
range M = 1..m;


dvar boolean x[1..n][1..m];
dvar float t[1..n];
dvar boolean y[1..n][1..n];


dexpr int res = sum(i in J, j in M) q[i] * x[i][j];
maximize res;
subject to {
  forall(i in J) { 
    c1: sum(j in M) x[i][j] <= 1;
	}	
  forall(i in J) { 
  	c2: t[i] + p[i] <= T + B * (1 - sum(j in M) x[i][j]);
   }
  forall(i,j in J: i != j) { 
    	c4: t[i] + p[i] <= t[j] + B * (1 - y[i][j]);   	
  }
  forall(i,j in J: i != j) { 
  	forall(m in M) { 
    	c5: y[i][j] + y[j][i] >= x[i][m] + x[j][m] - 1;   	
  	}
  }

   forall(k in 1..2) {
   	  c8: y[C[k]._i][C[k]._j] + y[C[k]._j][C[k]._i] >= 1;   	
   }   
  forall(i in J) { 
  	c9: t[i] >= 0;
  }
 
  
}

execute {
  writeln(res);
}
