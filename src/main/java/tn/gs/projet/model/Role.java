package tn.gs.projet.model;


import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "Role")
public class Role {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom; // Valeurs : "simple utilisateur", "responsable", "administrateur"
}
