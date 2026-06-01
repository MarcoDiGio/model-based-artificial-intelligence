import it.uniroma1.di.tmancini.utils.*;
import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;

public class SchursToSAT {
    public static void main(String args[]) {
        
        CmdLineOptions clo = new CmdLineOptions("SchurEncoder", "", "", "Encoder for Schur's Lemma");
        
        clo.addOption("n", "Number of marbles (default: 5)");
        clo.parse(args);
        
        String nStr = clo.getOptionValue("n");
        int n = (nStr != null) ? Integer.parseInt(nStr) : 5;
        int urnsCount = 3;
        
        IntRange marbles = new IntRange("marbles", 1, n);
        IntRange urns = new IntRange("urns", 1, urnsCount);
        
        SATEncoder encoder = new SATEncoder("Schur", "schurs-lemma.cnf");
        
        encoder.defineFamilyOfVariables("B", marbles, urns);

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= urnsCount; j++) {
                encoder.addToClause("B", i, j);
            }
            encoder.endClause();
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= urnsCount; j++) {
                for (int k = j + 1; k <= urnsCount; k++) {
                    encoder.addNegToClause("B", i, j);
                    encoder.addNegToClause("B", i, k);
                    encoder.endClause();
                }
            }
        }

        for (int u = 1; u <= urnsCount; u++) {
            for (int x = 1; x <= n; x++) {
                for (int y = x; y <= n; y++) {
                    int z = x + y;
                    if (z <= n) {
                        if (x == y) {
                            encoder.addNegToClause("B", x, u);
                            encoder.addNegToClause("B", z, u);
                        } else {
                            encoder.addNegToClause("B", x, u);
                            encoder.addNegToClause("B", y, u);
                            encoder.addNegToClause("B", z, u);
                        }
                        encoder.endClause();
                    }
                }
            }
        }

        encoder.end();
    }
}
