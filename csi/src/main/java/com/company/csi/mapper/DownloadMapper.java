package com.company.csi.mapper;

import com.company.csi.pojo.Download;
import com.company.csi.pojo.DownloadExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DownloadMapper {
    long countByExample(DownloadExample example);

    int deleteByExample(DownloadExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Download record);

    int insertSelective(Download record);

    List<Download> selectByExample(DownloadExample example);

    Download selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Download record, @Param("example") DownloadExample example);

    int updateByExample(@Param("record") Download record, @Param("example") DownloadExample example);

    int updateByPrimaryKeySelective(Download record);

    int updateByPrimaryKey(Download record);
}