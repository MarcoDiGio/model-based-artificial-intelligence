import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;
import java.util.ArrayList;
import java.util.List;

public class SATToSchurs {
    public static void main(String[] args) {
        try {
            SATModelDecoder decoder = new SATModelDecoder(args);
            
            decoder.run();
            
            if (!decoder.isSAT()) {
                System.out.println("UNSAT");
                return;
            }
            
            List<Integer> urn1 = new ArrayList<>();
            List<Integer> urn2 = new ArrayList<>();
            List<Integer> urn3 = new ArrayList<>();
            
            for (int i = 1; i <= decoder.getMaxVar(); i++) {
                Boolean isTrue = decoder.getModelValue(i);
                
                if (isTrue != null && isTrue) {
                    SATModelDecoder.Var var = decoder.decodeVariable(i);
                    if (var != null && var.getFamily().equals("B")) {
                        List<Integer> indices = var.getIndices();
                        int marble = indices.get(0);
                        int urn = indices.get(1);
                        
                        if (urn == 1) urn1.add(marble);
                        else if (urn == 2) urn2.add(marble);
                        else if (urn == 3) urn3.add(marble);
                    }
                }
            }
            
            System.out.println("Urna 1: " + urn1);
            System.out.println("Urna 2: " + urn2);
            System.out.println("Urna 3: " + urn3);
            
        } catch (Exception e) {
            System.out.println("\nError: " + e.getMessage());
        }
    }
}
