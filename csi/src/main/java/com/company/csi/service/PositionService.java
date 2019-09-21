package com.company.csi.service;

import com.company.csi.pojo.Position;

import java.util.List;

/**
 * 职位接口类
 */
public interface PositionService {
    void add(Position bean);

    void delete(int id);

    void update(Position bean);

    Position get(int id);

    List<Position> list();

    void deleteAll(List<Integer> idList);

    /**
     * 根据部门名称模糊搜索部门
     */
    List<Position> searchByPositionName(String positionName);

}
