package com.company.csi.service;

import com.company.csi.pojo.Staff;

import java.util.List;

/**
 * 员工接口类
 */
public interface StaffService {

    List<Staff> list();

    void add(Staff bean);

    void delete(int id);

    void update(Staff bean);

    Staff get(int id);

    void deleteAll(List<Integer> idList);

    //多条件查询
    List<Staff> search(int positionId, String staffName, String idNumber,
                       String gender, String phone, int departmentId);

}
