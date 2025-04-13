package tn.gs.projet.dao;

import jakarta.persistence.*;
import java.util.List;

public class JpqlTester {
    public static void main(String[] args) {
        // Initialize JPA
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("trainingPU");
        EntityManager em = emf.createEntityManager();

        // Test a query
        List<Object[]> results = em.createQuery(
                "SELECT p.profil.libelle, COUNT(p) FROM Participant p GROUP BY p.profil.libelle",
                Object[].class
        ).getResultList();

        // Print results
        System.out.println("Formations by Domain:");
        for (Object[] row : results) {
            System.out.println(row[0] + " : " + row[1]);
        }

        // Cleanup
        em.close();
        emf.close();
    }
}
