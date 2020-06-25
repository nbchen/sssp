package com.nbchen.sssp.repository;

import com.nbchen.sssp.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.QueryHints;

import javax.persistence.QueryHint;
import java.util.List;

public interface DepartmentRepository extends JpaRepository<Department,Integer> {

    @QueryHints({@QueryHint(name= org.hibernate.jpa.QueryHints.HINT_CACHEABLE,value="true")})
    @Query("from Department d")
    List<Department> getAll();
}
