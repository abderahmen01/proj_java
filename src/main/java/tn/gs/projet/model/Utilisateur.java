package tn.gs.projet.model;

import jakarta.persistence.*;
import lombok.Data;

import tn.gs.projet.model.Role;

@Entity
@Data
@Table(name = "Utilisateur")
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String login;
    private String password;

    @ManyToOne
    @JoinColumn(name = "idRole")
    private Role role;
}