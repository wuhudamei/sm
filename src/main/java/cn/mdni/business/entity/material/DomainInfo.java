package cn.mdni.business.entity.material;

import cn.mdni.core.base.entity.IdEntity;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

/**
 * @Description: 功能区管理实体类
 * @Company: 美得你智装科技有限公司
 * @Author wangdan
 * @Date: 2017/11/02.
 */

public class DomainInfo extends IdEntity{

    private String domainName;//功能区名称
    private String includeDomainType;//包涵功能区类型
    private String domainStatus;//状态
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    private Date createTime;//创建时间
    private String createUser;//创建人
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    private Date updateTime;//更新时间
    private String updateUser;//更新人


    public String getDomainName() {
        return domainName;
    }

    public void setDomainName(String domainName) {
        this.domainName = domainName;
    }

    public String getIncludeDomainType() {
        return includeDomainType;
    }

    public void setIncludeDomainType(String includeDomainType) {
        this.includeDomainType = includeDomainType;
    }

    public String getDomainStatus() {
        return domainStatus;
    }

    public void setDomainStatus(String domainStatus) {
        this.domainStatus = domainStatus;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(String updateUser) {
        this.updateUser = updateUser;
    }
}
