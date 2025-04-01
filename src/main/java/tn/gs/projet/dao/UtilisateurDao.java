package tn.gs.projet.dao;


import jakarta.persistence.*;
import tn.gs.projet.model.Utilisateur;
import java.util.List;

public class UtilisateurDao {
    private EntityManager em;

    public UtilisateurDao() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("trainingPU");
        em = emf.createEntityManager();
    }

    public void saveOrUpdate(Utilisateur utilisateur) {
        em.getTransaction().begin();
        if (utilisateur.getId() == null) em.persist(utilisateur);
        else em.merge(utilisateur);
        em.getTransaction().commit();
    }

    public List<Utilisateur> findAll() {
        return em.createQuery("SELECT u FROM Utilisateur u", Utilisateur.class).getResultList();
    }

    public Utilisateur findById(Long id) {
        return em.find(Utilisateur.class, id);
    }

    public void delete(Long id) {
        em.getTransaction().begin();
        Utilisateur utilisateur = em.find(Utilisateur.class, id);
        if (utilisateur != null) em.remove(utilisateur);
        em.getTransaction().commit();
    }
}
