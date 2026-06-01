import it.uniroma1.di.tmancini.utils.*;
import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;

public class NQueensToSAT {
    public static void main(String args[]) {
        
        int n = 4;
        
        IntRange coords = new IntRange("coords", 1, n);
        
        SATEncoder encoder = new SATEncoder("NQueens", "n-queens.cnf");
        
        encoder.defineFamilyOfVariables("Q", coords, coords);

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                encoder.addToClause("Q", i, j);
            }
            encoder.endClause();
        }

        // Almeno una regina per colonna (Col ALO)
        for (int j = 1; j <= n; j++) {
            for (int i = 1; i <= n; i++) {
                encoder.addToClause("Q", i, j);
            }
            encoder.endClause();
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= n; j++) {
                for (int j_prime = j + 1; j_prime <= n; j_prime++) {
                    encoder.addNegToClause("Q", i, j);
                    encoder.addNegToClause("Q", i, j_prime);
                    encoder.endClause();
                }
            }
        }

        for (int j = 1; j <= n; j++) {
            for (int i = 1; i <= n; i++) {
                for (int i_prime = i + 1; i_prime <= n; i_prime++) {
                    encoder.addNegToClause("Q", i, j);
                    encoder.addNegToClause("Q", i_prime, j);
                    encoder.endClause();
                }
            }
        }

        for (int i = 1; i <= n; i++) {
            for (int i_prime = i + 1; i_prime <= n; i_prime++) { 
                for (int j = 1; j <= n; j++) {                   
                    for (int j_prime = 1; j_prime <= n; j_prime++) {
                        if (Math.abs(i - i_prime) == Math.abs(j - j_prime)) {
                            encoder.addNegToClause("Q", i, j);
                            encoder.addNegToClause("Q", i_prime, j_prime);
                            encoder.endClause();
                        }
                    }
                }
            }
        }

        encoder.end();
    }
}
