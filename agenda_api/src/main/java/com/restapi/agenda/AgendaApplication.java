package com.restapi.agenda;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class AgendaApplication {
	public String PORT = System.getenv("port");
	public static void main(String[] args) {
		SpringApplication.run(AgendaApplication.class, args);
	}



}
