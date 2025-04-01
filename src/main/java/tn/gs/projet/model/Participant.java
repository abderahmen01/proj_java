package tn.gs.projet.model;


import jakarta.persistence.*;
import lombok.Data;
import java.util.List;

@Entity
@Data
@Table(name = "Participant")
public class Participant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String prenom;
    private String email;
    private int tel;

    @ManyToOne
    @JoinColumn(name = "idStructure")
    private Structure structure;

    @ManyToOne
    @JoinColumn(name = "idProfil")
    private Profil profil;

    @ManyToMany
    @JoinTable(
            name = "Formation_Participant",
            joinColumns = @JoinColumn(name = "participant_id"),
            inverseJoinColumns = @JoinColumn(name = "formation_id")
    )
    private List<Formation> formations;
}
