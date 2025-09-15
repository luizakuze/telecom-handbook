public class OlaMundo {

    public static void main(String[] args) {

        //Imprimindo na tela
        System.out.println("Olá mundo");
        System.out.print("Hello World\n");

        if (args.length > 0) {
            System.out.println("Olá " + args[0]);
        } else {
            System.out.println("Olá mundo");
        }
    }
}
