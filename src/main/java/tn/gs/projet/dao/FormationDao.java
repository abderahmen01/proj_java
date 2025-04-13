package tn.gs.projet.dao;


import jakarta.persistence.*;
import tn.gs.projet.model.Formation;
import java.util.List;

public class FormationDao {
    private EntityManager em;

    public FormationDao() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("trainingPU");
        em = emf.createEntityManager();
    }

    public void saveOrUpdate(Formation formation) {
        em.getTransaction().begin();
        if (formation.getId() == null) em.persist(formation);
        else em.merge(formation);
        em.getTransaction().commit();
    }

    public List<Formation> findAll() {
        return em.createQuery("SELECT f FROM Formation f", Formation.class).getResultList();
    }

    public Formation findById(Long id) {
        return em.find(Formation.class, id);
    }

    public void delete(Long id) {
        em.getTransaction().begin();
        Formation formation = em.find(Formation.class, id);
        if (formation != null) em.remove(formation);
        em.getTransaction().commit();
    }
    public List<Object[]> getFormationsByDomain() {
        List<Object[]> results = em.createQuery(
                "SELECT COALESCE(d.libelle, 'Non défini'), COUNT(f) " +
                        "FROM Formation f LEFT JOIN f.domaine d " + // Handle null domains
                        "GROUP BY d.libelle",
                Object[].class
        ).getResultList();

        System.out.println("[DEBUG] Domain Stats: " + results.size() + " records");
        return results;

    }

    public List<Object[]> getFormationsByYear() {
        List<Object[]> results = em.createQuery(
                "SELECT f.annee, COUNT(f) " +
                        "FROM Formation f " +
                        "WHERE f.annee IS NOT NULL " + // Exclude null years
                        "GROUP BY f.annee " +
                        "ORDER BY f.annee",
                Object[].class
        ).getResultList();
        System.out.println("[DEBUG] formtion by year: " + results.size() + " records");

        return results;
    }

}