package icu.ttc.wbm.repository;

import icu.ttc.wbm.model.Record;
import org.springframework.data.jpa.domain.Specification;

public class RecordSpecification {
    public static Specification<Record> nameLike(String name) {
        return (root, query, builder) -> builder.like(root.get("name"), "%" + name + "%");
    }

    public static Specification<Record> artistLike(String artist) {
        return (root, query, builder) -> builder.like(root.get("artist"), "%" + artist + "%");
    }

    public static Specification<Record> yearBefore(Integer year) {
        return (root, query, builder) -> builder.lessThanOrEqualTo(root.get("year"), year);
    }

    public static Specification<Record> genreIs(Integer genreId) {
        return (root, query, builder) -> builder.lessThanOrEqualTo(root.get("genre").get("id"), genreId);
    }
}
