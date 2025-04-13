package tn.gs.projet.model;


import jakarta.persistence.*;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.ArrayList;
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

    @ManyToOne
    @JoinColumn(name = "idDomaine")
    private Domaine domaine;

    @OneToMany(mappedBy = "formation", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<FormationParticipant> participants = new ArrayList<>();
}
