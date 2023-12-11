package icu.ttc.wbm.repository;

import icu.ttc.wbm.model.Genre;
import org.springframework.data.jpa.repository.JpaRepository;

public interface GenreRepository extends JpaRepository<Genre, Integer> {
}
