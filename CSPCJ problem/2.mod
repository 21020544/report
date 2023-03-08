/*********************************************
 * OPL 22.1.0.0 Model
 * Author: Hello
 * Creation Date: Mar 4, 2023 at 8:58:32 AM
 *********************************************/
int n = ...;
int m = ...;
int p[1..n] = ...;
int T = ...; 
int k = 3;
int B = ...;
int q[1..n] = ...;
tuple Y {
   int _x;
   int _y;
   int data;
};
Y y[1..2] = ...;

range J = 1..n;
range M = 1..m;
range K = 1..k;

dvar boolean x[J][M][K];
dvar float t[J];
dvar float z[M][K];

dexpr int res = sum(i in J, j in M, k in K) q[i] * x[i][j][k] ;
maximize res;
subject to {
  forall(i in J) { 
    c1: sum(j in M, k in K) x[i][j][k] <= 1;
    c2: t[i] + p[i] <= T + B * (1 - sum(j in M, k in K) x[i][j][k]);
    c9: t[i] >= 0;
   }
  forall(j in M) { 
    forall(k in K) { 
    	c3: sum(i in J) x[i][j][k] <= 1;
  	}
  }
  forall(j in M) { 
    forall(k in K: k > 1) { 
    	c4: z[j][k - 1] <= z[j][k];
  	}
  }
  forall(i in J) { 
  	forall(j in M) { 
    	forall(k in K) { 
    	c5: t[i] + p[i] <= z[j][k] + B * (1 - x[i][j][k]);
   		}    	
  	}
  }
  forall(i in J) { 
  	forall(j in M) { 
    	forall(k in K: k > 1) { 
    	c6: t[i] >= z[j][k-1] - B * (1 - x[i][j][k]);
   		}    	
  	}
  }
  forall(i in 1..2) { 
    	c7: t[y[i]._x] + p[y[i]._x] <= t[y[i]._y] + B * y[i].data;
    	c8: t[y[i]._y] + p[y[i]._y] <= t[y[i]._x] + B *(1 - y[i].data);
     
  }
  forall(j in M) { 
    forall(k in K) { 
    	c10: z[j][k] >= 0;
  	}
  }
  
}
execute {
  writeln(res);
}
