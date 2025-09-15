public class OlaMundo {

    public static void main(String[] args) {

        if (args.length == 3 ) { // argumentos do programa
            int a = Integer.parseInt(args[0]);
            int b = Integer.parseInt(args[2]);
            double resultado; 

            switch (args[1]) {
                case "+": 
                    resultado = (double) a + b;
                    System.out.println("Resultado: " + resultado);
                    break;
                case "-": 
                    resultado = (double) a - b;
                    System.out.println("Resultado: " + resultado);
                    break;
                case "x": 
                    resultado = (double) a * b;
                    System.out.println("Resultado: " + resultado);
                    break;
                case "/": 
                    resultado = (double) a / b;
                    System.out.println("Resultado: " + resultado);
                    break;
                case "^":
                    resultado = Math.pow(a,b);
                    System.out.println("Resultado: " + resultado);
                    break;
                default: 
                    System.out.println("Operador inválido");
                
            }

        } else {
            System.out.println("Sintaxe errada");
        }
    }
}
