import it.uniroma1.di.tmancini.teaching.ai.SATCodec.*;
import java.util.List;

public class SATToNQueens {
    public static void main(String[] args) {
        try {
            SATModelDecoder decoder = new SATModelDecoder(args);
            
            decoder.run();
            
            if (!decoder.isSAT()) {
                System.out.println("UNSAT");
                return;
            }
            
            int n = 0;
            for (int i = 1; i <= decoder.getMaxVar(); i++) {
                SATModelDecoder.Var var = decoder.decodeVariable(i);
                if (var != null && var.getFamily().equals("Q")) {
                    List<Integer> indices = var.getIndices();
                    n = Math.max(n, Math.max(indices.get(0), indices.get(1)));
                }
            }
            
            boolean[][] board = new boolean[n][n];
            
            for (int i = 1; i <= decoder.getMaxVar(); i++) {
                Boolean isTrue = decoder.getModelValue(i);
                
                if (isTrue != null && isTrue) {
                    SATModelDecoder.Var var = decoder.decodeVariable(i);
                    if (var != null && var.getFamily().equals("Q")) {
                        List<Integer> indices = var.getIndices();
                        int row = indices.get(0) - 1;
                        int col = indices.get(1) - 1;
                        board[row][col] = true;
                    }
                }
            }
            
            for (int r = 0; r < n; r++) {
                for (int c = 0; c < n; c++) {
                    if (board[r][c]) {
                        System.out.print(" Q ");
                    } else {
                        System.out.print(" . ");
                    }
                }
                System.out.println();
            }
            System.out.println();
            
        } catch (Exception e) {
            System.out.println("\nError: " + e.getMessage());
        }
    }
}
