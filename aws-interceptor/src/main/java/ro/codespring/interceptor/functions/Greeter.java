package ro.codespring.interceptor.functions;

import java.util.function.Function;

import org.springframework.stereotype.Component;

@Component
public class Greeter implements Function<String, String> {

    @Override
    public String apply(final String name) {
    	System.out.println("Greeter called");
        return "Hello " + name + "!!";
    }
}
