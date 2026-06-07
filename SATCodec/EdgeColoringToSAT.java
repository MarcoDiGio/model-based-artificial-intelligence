import it.uniroma1.di.tmancini.utils.*;
import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;

public class EdgeColoringToSAT {
    public static void main(String args[]) {
        
        SATEncoder encoder = new SATEncoder("EdgeColoring", "edge-coloring.cnf");

        int n = 11;
        
        final int S=1, A=2, B=3, C=4, D=5, E_node=6, H=7, I=8, J=9, G1=10, G2=11;
        
        boolean[][] E = new boolean[n + 1][n + 1];

        E[S][A] = E[A][S] = true;
        E[S][B] = E[B][S] = true;
        E[S][C] = E[C][S] = true;
        E[S][D] = E[D][S] = true;
        
        E[A][E_node] = E[E_node][A] = true;
        E[A][H] = E[H][A] = true;
        E[A][I] = E[I][A] = true;
        
        E[B][C] = E[C][B] = true;
        E[B][I] = E[I][B] = true;
        E[B][G2] = E[G2][B] = true;
        E[B][J] = E[J][B] = true;
        
        E[C][D] = E[D][C] = true; 
        E[C][G2] = E[G2][C] = true;
        
        E[D][E_node] = E[E_node][D] = true;
        
        E[E_node][H] = E[H][E_node] = true;
        E[E_node][G1] = E[G1][E_node] = true; 
        
        E[H][I] = E[I][H] = true;
        E[H][G1] = E[G1][H] = true;
        
        E[J][G2] = E[G2][J] = true;

        IntRange V = new IntRange("V", 1, n);
        
        IntRange colorRange = new IntRange("Colors", 1, 3);
        
        encoder.defineFamilyOfVariables("X", V, V, colorRange);

        for (int u = 1; u <= n; u++) {
            for (int v = u + 1; v <= n; v++) {
                if (E[u][v]) {
                    for (int c = 1; c <= 3; c++) {
                        encoder.addToClause("X", u, v, c);
                    }
                    encoder.endClause();
                }
            }
        }

        for (int u = 1; u <= n; u++) {
            for (int v = u + 1; v <= n; v++) {
                if (E[u][v]) {
                    for (int c1 = 1; c1 <= 3; c1++) {
                        for (int c2 = c1 + 1; c2 <= 3; c2++) {
                            encoder.addNegToClause("X", u, v, c1);
                            encoder.addNegToClause("X", u, v, c2);
                            encoder.endClause();
                        }
                    }
                }
            }
        }

        for (int u = 1; u <= n; u++) {
            for (int v = u + 1; v <= n; v++) {
                for (int w = v + 1; w <= n; w++) {
                    if (E[u][v] && E[v][w] && E[u][w]) {
                        for (int c = 1; c <= 3; c++) {
                            encoder.addNegToClause("X", u, v, c);
                            encoder.addNegToClause("X", v, w, c);
                            encoder.addNegToClause("X", u, w, c);
                            encoder.endClause();
                        }
                    }
                }
            }
        }

        encoder.end();
    }
}
