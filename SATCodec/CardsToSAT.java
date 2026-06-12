import it.uniroma1.di.tmancini.utils.*;
import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;

public class CardsToSAT {
    public static void main(String args[]) {
        
        CmdLineOptions clo = new CmdLineOptions("CardArrangementEncoder", "", "", "Encoder per il Card Arrangement");
        clo.addOption("n", "Numero di valori delle carte (default: 3)");
        clo.addOption("k", "Numero di copie per carta (default: 2)");
        clo.parse(args);
        
        String nStr = clo.getOptionValue("n");
        String kStr = clo.getOptionValue("k");
        int n = (nStr != null) ? Integer.parseInt(nStr) : 3;
        int k = (kStr != null) ? Integer.parseInt(kStr) : 2;
        
        int L = k * n;

        SATEncoder encoder = new SATEncoder("CardArrangement", "card-arrangement.cnf");

        IntRange V = new IntRange("V", 1, n);
        IntRange M = new IntRange("M", 1, k);
        IntRange P = new IntRange("P", 1, L);
        
        encoder.defineFamilyOfVariables("C", V, M, P);

        for (int v = 1; v <= n; v++) {
            for (int m = 1; m <= k; m++) {
                for (int p = 1; p <= L; p++) {
                    encoder.addToClause("C", v, m, p);
                }
                encoder.endClause();
            }
        }

        for (int v = 1; v <= n; v++) {
            for (int m = 1; m <= k; m++) {
                for (int p1 = 1; p1 <= L; p1++) {
                    for (int p2 = p1 + 1; p2 <= L; p2++) {
                        encoder.addNegToClause("C", v, m, p1);
                        encoder.addNegToClause("C", v, m, p2);
                        encoder.endClause();
                    }
                }
            }
        }

        for (int p = 1; p <= L; p++) {
            for (int v = 1; v <= n; v++) {
                for (int m = 1; m <= k; m++) {
                    encoder.addToClause("C", v, m, p);
                }
            }
            encoder.endClause();
        }

        for (int p = 1; p <= L; p++) {
            for (int v1 = 1; v1 <= n; v1++) {
                for (int m1 = 1; m1 <= k; m1++) {
                    for (int v2 = 1; v2 <= n; v2++) {
                        for (int m2 = 1; m2 <= k; m2++) {
                            if ((v1 < v2) || (v1 == v2 && m1 < m2)) {
                                encoder.addNegToClause("C", v1, m1, p);
                                encoder.addNegToClause("C", v2, m2, p);
                                encoder.endClause();
                            }
                        }
                    }
                }
            }
        }

        for (int v = 1; v <= n; v++) {
            for (int m = 1; m <= k - 1; m++) {
                
                for (int p = 1; p <= L - (v + 1); p++) {
                    encoder.addNegToClause("C", v, m, p);
                    encoder.addToClause("C", v, m + 1, p + v + 1);
                    encoder.endClause();
                }
                
                for (int p = L - (v + 1) + 1; p <= L; p++) {
                    encoder.addNegToClause("C", v, m, p);
                    encoder.endClause();
                }
            }
        }

        encoder.end();
    }
}
