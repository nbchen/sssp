package com.nbchen.sssp.repository;

import com.nbchen.sssp.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeeRepository extends JpaRepository<Employee,Integer> {
    Employee getByLastName(String lastName);
}
