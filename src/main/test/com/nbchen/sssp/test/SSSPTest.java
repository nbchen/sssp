package com.nbchen.sssp.test;

import com.nbchen.sssp.entity.Department;
import com.nbchen.sssp.repository.DepartmentRepository;
import org.hibernate.jpa.QueryHints;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.QueryHint;
import javax.sql.DataSource;
import java.util.List;

public class SSSPTest {
    private ApplicationContext ctx = null;
    private DepartmentRepository departmentRepository;
    private EntityManagerFactory entityManagerFactory;
    {
        ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
        departmentRepository = ctx.getBean(DepartmentRepository.class);
        entityManagerFactory = ctx.getBean(EntityManagerFactory.class);
    }
    // 测试JPA中的二级缓存是否有效
    @Test
    public void testJpaSecondLevelCache() {
        String jpql = "FROM Department d";
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Query query = entityManager.createQuery(jpql);
        List<Department> departments = query.setHint(QueryHints.HINT_CACHEABLE,true).getResultList();
        entityManager.close();

        entityManager = entityManagerFactory.createEntityManager();
        query = entityManager.createQuery(jpql);
        departments = query.setHint(QueryHints.HINT_CACHEABLE,true).getResultList();
        entityManager.close();;
        // 默认也是不生效=>自定义jpql,设置setHint(QueryHints.HINT_CACHEABLE,true)=>生效(只查询一次)
    }
    // 测试二级缓存是否有效
    @Test
    public void testRepositorySecondLevelCache() {
//        List<Department> departments = departmentRepository.findAll();
//        departments = departmentRepository.findAll();
//        // 查询2次SQL,不生效
        List<Department> departments = departmentRepository.getAll();
        departments = departmentRepository.getAll();
        // 二级缓存生效
    }

    // 测试C3P0数据源配置可以成功获取连接
    @Test
    public void testDataSource() throws Exception {
        DataSource dataSource = ctx.getBean(DataSource.class);
        System.out.println("dataSource.getConnection = " + dataSource.getConnection());
    }
}
