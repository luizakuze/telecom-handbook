package engtelecom.std.labrest.service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import org.springframework.stereotype.Component;

import engtelecom.std.labrest.entities.Pessoa;

/**
 * PessoaService é uma classe que simula um banco de dados.
 *
 * A anotação @Component indica que a classe PessoaService é um componente do
 * Spring. Isso significa que o Spring irá gerenciar as instâncias dessa classe
 * e irá injetá-las onde for necessário.
 *
 * Classes anotadas com @Component são chamadas de beans. E são singleton por
 * padrão, ou seja, o Spring irá criar apenas uma instância dessa classe e irá
 * compartilhá-la entre todos os componentes que a utilizarem.
 *
 * https://java-design-patterns.com/patterns/singleton/
 *
 */
@Component
public class PessoaService {
    // criando uma lista para simular um banco de dados em memória
    private List<Pessoa> pessoas;
    // criando um contador para gerar ids. O contador é estático para que seja
    // compartilhado entre todas as instâncias da classe PessoaService
    // O contador é do tipo AtomicLong para que as operações de incremento e
    // decremento sejam atômicas
    private static AtomicInteger contador = new AtomicInteger();

    public PessoaService() {
        pessoas = new ArrayList<>();
        // adicionando algumas pessoas para facilitar os testes
        this.cadastrar(new Pessoa(1, "João", "joao@example.org"));
        this.cadastrar(new Pessoa(2, "Maria", "maria@example.net"));
        this.cadastrar(new Pessoa(3, "Juca", "juca@example.com"));
    }

    public Pessoa cadastrar(Pessoa pessoa) {
        // gerando um id para a pessoa e ignorando o id enviado
        pessoa.setId(contador.incrementAndGet());
        pessoas.add(pessoa);
        return pessoa;
    }

    public List<Pessoa> buscarTodos() {
        return pessoas;
    }

    public Pessoa buscarPorId(Integer id) {
        return this.pessoas.stream().filter(p -> p.getId().equals(id)).findFirst().orElse(null);
    }

    public Pessoa atualizar(Pessoa pessoa) {
        Pessoa p = buscarPorId(pessoa.getId());
        if (p != null) {
            p.setNome(pessoa.getNome());
            p.setEmail(pessoa.getEmail());
        }
        return p;
    }

    public boolean excluir(Integer id) {
        return this.pessoas.removeIf(p -> p.getId().equals(id));
    }
}