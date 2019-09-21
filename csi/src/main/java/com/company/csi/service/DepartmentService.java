package com.company.csi.service;

import com.company.csi.pojo.Department;
import com.company.csi.pojo.User;

import java.util.List;

/**
 * 部门接口类
 */
public interface DepartmentService {

    default void ss() {

    }

    void add(Department bean);

    void delete(int id);

    void update(Department bean);

    Department get(int id);

    List<Department> list();

    void deleteAll(List<Integer> idList);

    /**
     * 根据部门名称模糊搜索部门
     */
    List<Department> searchByDepartmentName(String departmentName);
}
