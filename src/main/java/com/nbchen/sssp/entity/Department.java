package com.nbchen.sssp.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Cacheable
@Entity
@Table(name = "SSSP_DEPARTMENTS")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Department {
    @Id
    @GeneratedValue
    private Integer id;
    private String departmentName;
}
