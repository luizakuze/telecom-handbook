package ads.seg.demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;



@RestController
@RequestMapping("/") 
public class TestController {
    
    
    
    @GetMapping
    public String olaMundo(){
        return "Ola mundo";
    }

    
    @GetMapping("/en")
    public String helloWorld(){
        return "Hello World";
    }
}
