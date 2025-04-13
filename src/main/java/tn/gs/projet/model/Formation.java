package tn.gs.projet.model;


import jakarta.persistence.*;
import lombok.Data;
import java.util.List;

@Entity
@Data
@Table(name = "Formation")
public class Formation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;
    private int annee;
    private int duree; // Nombre de jours
    private double budget;

    // In Formation.java
    @ManyToOne
    @JoinColumn(name = "idDomaine") // Must match DB column name
    private Domaine domaine;

    @ManyToMany(mappedBy = "formations")
    private List<Participant> participants;
}
