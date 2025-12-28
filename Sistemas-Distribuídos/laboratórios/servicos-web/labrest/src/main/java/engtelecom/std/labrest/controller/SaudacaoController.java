package engtelecom.std.labrest.controller;

import java.util.concurrent.atomic.AtomicInteger;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import engtelecom.std.labrest.entities.Saudacao;

import org.springframework.web.bind.annotation.RequestParam;

// dá de colocar /campus aqui o geral
@RestController
public class SaudacaoController {

    // // curl http://localhost:8080/ola
    // @GetMapping("/ola")
    // public String olaMundo() {
    // return "Ola mundo";
    // }

    // @GetMapping("/saudacao")
    // public Saudacao saudacao() {
    // return new Saudacao(1, "Luiza");
    // }
    private static final String MENSAGEM = "Olá %s";
    private final AtomicInteger contador = new AtomicInteger(); // i++

    // não é idemponente dessa forma, GET deve ser
    @GetMapping("/saudacao")
    public Saudacao saudacao(@RequestParam(value = "nome", defaultValue = "mundo") String nome) {
        return new Saudacao(contador.incrementAndGet(), String.format(MENSAGEM, nome));
    }

}
