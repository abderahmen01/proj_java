package tn.gs.projet.dao;


import jakarta.persistence.*;
import tn.gs.projet.model.Participant;
import java.util.List;

public class ParticipantDao {
    private EntityManager em;

    public ParticipantDao() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("trainingPU");
        em = emf.createEntityManager();
    }

    public void saveOrUpdate(Participant participant) {
        em.getTransaction().begin();
        if (participant.getId() == null) em.persist(participant);
        else em.merge(participant);
        em.getTransaction().commit();
    }

    public List<Participant> findAll() {
        return em.createQuery("SELECT p FROM Participant p", Participant.class).getResultList();
    }

    public Participant findById(Long id) {
        return em.find(Participant.class, id);
    }

    public void delete(Long id) {
        em.getTransaction().begin();
        Participant participant = em.find(Participant.class, id);
        if (participant != null) em.remove(participant);
        em.getTransaction().commit();
    }
}
