package icu.ttc.wbm.repository;

import icu.ttc.wbm.model.Record;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface RecordRepository extends JpaRepository<Record, Integer>, JpaSpecificationExecutor<Record> {
}
