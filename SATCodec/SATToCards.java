import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;
import java.util.List;

public class SATToCards {
    public static void main(String[] args) {
        try {
            SATModelDecoder decoder = new SATModelDecoder(args);
            decoder.run();
            
            if (!decoder.isSAT()) {
                System.out.println("UNSAT");
                return;
            }
            
            int L = 0;
            for (int i = 1; i <= decoder.getMaxVar(); i++) {
                SATModelDecoder.Var var = decoder.decodeVariable(i);
                if (var != null && var.getFamily().equals("C")) {
                    List<Integer> indices = var.getIndices();
                    L = Math.max(L, indices.get(2)); 
                }
            }
            
            int[] arrangement = new int[L];
            
            for (int i = 1; i <= decoder.getMaxVar(); i++) {
                Boolean isTrue = decoder.getModelValue(i);
                
                if (isTrue != null && isTrue) {
                    SATModelDecoder.Var var = decoder.decodeVariable(i);
                    if (var != null && var.getFamily().equals("C")) {
                        List<Integer> indices = var.getIndices();
                        int v = indices.get(0);

                        int p = indices.get(2);
                        
                        arrangement[p - 1] = v;
                    }
                }
            }
            
            // Stampo la configurazione delle carte in fila
            System.out.print("Disposizione delle carte: ");
            for (int i = 0; i < L; i++) {
                System.out.print(arrangement[i] + " ");
            }
            System.out.println();
            
        } catch (Exception e) {
            System.out.println("\nError: " + e.getMessage());
        }
    }
}
