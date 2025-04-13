package tn.gs.projet.dao;

import jakarta.persistence.*;
import tn.gs.projet.model.Formation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class FormationDao {
    public final EntityManager em;

    public FormationDao(EntityManager em) {
        this.em = em;
    }

    public FormationDao() {
        em = Persistence.createEntityManagerFactory("trainingPU").createEntityManager();
    }

    // Gestion centralisée des transactions
    private void executeInTransaction(Runnable operation) {
        EntityTransaction transaction = em.getTransaction();
        try {
            if (!transaction.isActive()) {
                transaction.begin();
            }

            operation.run();

            if (transaction.isActive() && !transaction.getRollbackOnly()) {
                transaction.commit();
            }
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new PersistenceException("Transaction failed", e);
        }
    }

    public void saveOrUpdate(Formation formation) {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            formation = em.merge(formation); // Toujours utiliser merge()
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) transaction.rollback();
            throw new PersistenceException("Transaction failed", e);
        }
    }

    public List<Formation> findAll() {
        return em.createQuery("SELECT f FROM Formation f", Formation.class)
                .getResultList();
    }

    public Formation findById(Long id) {
        return em.find(Formation.class, id);
    }

    public void delete(Long id) {
        executeInTransaction(() -> {
            Formation formation = em.find(Formation.class, id);
            if (formation != null) {
                em.remove(formation);
            }
        });
    }


    // Nombre de formations par domaine (existant)
    public Map<String, Long> getFormationsCountByDomain() {

            Query query = em.createQuery(
                    "SELECT d.libelle, COUNT(f) FROM Formation f JOIN f.domaine d GROUP BY d.libelle"
            );
            List<Object[]> results = query.getResultList();
            Map<String, Long> data = new HashMap<>();
            for (Object[] result : results) {
                data.put((String) result[0], (Long) result[1]);
            }
            return data;

    }

    // Ajouter ces méthodes
    public Map<String, Long> getFormationsCountByYear() {
        Query query = em.createQuery(
                "SELECT f.annee, COUNT(f) FROM Formation f GROUP BY f.annee"
        );
        List<Object[]> results = query.getResultList();
        return results.stream()
                .collect(Collectors.toMap(
                        o -> String.valueOf(o[0]),
                        o -> (Long) o[1]
                ));
    }

    public Map<String, Double> getBudgetByDomain() {
        Query query = em.createQuery(
                "SELECT d.libelle, SUM(f.budget) FROM Formation f JOIN f.domaine d GROUP BY d.libelle"
        );
        List<Object[]> results = query.getResultList();
        return results.stream()
                .collect(Collectors.toMap(
                        o -> (String) o[0],
                        o -> (Double) o[1]
                ));
    }
}