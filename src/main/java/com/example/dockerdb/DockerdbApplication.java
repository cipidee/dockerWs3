package com.example.dockerdb;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@SpringBootApplication
public class DockerdbApplication {

    public static void main(String[] args) {
        SpringApplication.run(DockerdbApplication.class, args);
    }

}

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
}

interface PersonDao extends JpaRepository<Person, Long> {
}

@RestController
class PersonController {

    private PersonDao personDao;

    public PersonController(PersonDao personDao) {
        this.personDao = personDao;
    }

    @GetMapping("/persons")
    public List<Person> findAll() {
        return personDao.findAll();
    }
}
