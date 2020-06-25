package com.nbchen.sssp.service;

import com.nbchen.sssp.entity.Department;
import com.nbchen.sssp.repository.DepartmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentRepository departmentRepository;
    @Transactional(readOnly = true)
    public List<Department> getAll() {
        return departmentRepository.getAll();
    }
}
