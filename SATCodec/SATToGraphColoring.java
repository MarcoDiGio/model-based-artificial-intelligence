import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;
import java.util.List;

public class SATToGraphColoring {
    public static void main(String[] args) {
        try {
            SATModelDecoder decoder = new SATModelDecoder(args);
            decoder.run();
            
            if (!decoder.isSAT()) {
                System.out.println("UNSAT");
                return;
            }
            
            String[] colors = {"", "R", "B", "C"};
            
            for (int i = 1; i <= decoder.getMaxVar(); i++) {
                Boolean isTrue = decoder.getModelValue(i);
                
                if (isTrue != null && isTrue) {
                    SATModelDecoder.Var var = decoder.decodeVariable(i);
                    if (var != null && var.getFamily().equals("X")) {
                        List<Integer> indices = var.getIndices();
                        int v = indices.get(0);
                        int c = indices.get(1);
                        
                        System.out.println("Nodo " + v + " -> Colore " + colors[c]);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("\nError: " + e.getMessage());
        }
    }
}
