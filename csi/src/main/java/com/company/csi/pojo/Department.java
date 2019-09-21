package com.company.csi.pojo;

public class Department {
    private Integer id;

    private String departmentName;

    private String message;

    public Department() {
    }

    public Department(Integer id, String departmentName, String message) {
        this.id = id;
        this.departmentName = departmentName;
        this.message = message;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName == null ? null : departmentName.trim();
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message == null ? null : message.trim();
    }
}