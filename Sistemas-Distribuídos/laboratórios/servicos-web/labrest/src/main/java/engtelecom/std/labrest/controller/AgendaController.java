package engtelecom.std.labrest.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import engtelecom.std.labrest.entities.Pessoa;
import engtelecom.std.labrest.exceptions.PessoaNaoEncontradaException;
import engtelecom.std.labrest.service.PessoaService;

@RestController
// Mapeia as URLs /pessoas e /pessoas/ para esse controller
// Se desejar usar versionamento de API, basta adicionar a versão. Ex:
// /v1/pessoas
@RequestMapping({ "/pessoas", "/pessoas/" })
public class AgendaController {
    @Autowired // injeta uma instância de PessoaService que está anotada com @Component
    private PessoaService pessoaService;

    @GetMapping
    public List<Pessoa> obterTodasPessoas() {
        return this.pessoaService.buscarTodos();
    }

    @GetMapping("/{id}")
    @ResponseStatus(HttpStatus.OK)
    public Pessoa obterPessoa(@PathVariable Integer id) {
        Pessoa p = this.pessoaService.buscarPorId(id);
        if (p != null) {
            return p;
        }
        throw new PessoaNaoEncontradaException(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Pessoa adicionarPessoa(@RequestBody Pessoa p) {
        return this.pessoaService.cadastrar(p);
    }

    @PutMapping
    @ResponseStatus(HttpStatus.OK)
    public Pessoa atualizarPessoa(@RequestBody Pessoa pessoa) {
        Pessoa p = this.pessoaService.atualizar(pessoa);
        if (p != null) {
            return p;
        }
        throw new PessoaNaoEncontradaException(pessoa.getId());
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void excluirPessoa(@PathVariable Integer id) {
        if (!this.pessoaService.excluir(id)) {
            throw new PessoaNaoEncontradaException(id);
        }
    }

    @ControllerAdvice
    class PessoaNaoEncontrada {
        @ResponseBody
        @ExceptionHandler(PessoaNaoEncontradaException.class)
        @ResponseStatus(HttpStatus.NOT_FOUND)
        String pessoaNaoEncontrada(PessoaNaoEncontradaException p) {
            return p.getMessage();
        }
    }
}