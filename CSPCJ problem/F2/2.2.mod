/*********************************************
 * OPL 22.1.0.0 Model
 * Author: Hello
 * Creation Date: Mar 6, 2023 at 11:02:58 PM
 *********************************************/
int n = ...;//n -i jobs
int m = ...;//m -j machine
int p[1..n] = ...;//pj job process time
int T = ...; //cong suat 1 may
int B = ...;
int y[1..n][1..n] = ...;
int q[1..n] = ...;//priority

range J = 1..n;
range M = 1..m;

dvar boolean x[1..n][1..m];
dvar float t[1..n];


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
   forall(i in J, j in J: y[i][j] == 1) { 
    	c6: y[i][j] + y[j][i] >= 1;
   }   
  forall(i in J) { 
  	c7: t[i] >= 0;
  }
 
  
}

execute {
  writeln(res);
}