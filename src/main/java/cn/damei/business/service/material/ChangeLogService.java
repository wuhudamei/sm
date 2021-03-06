package cn.damei.business.service.material;

import cn.damei.business.dao.material.ChangeLogDao;
import cn.damei.business.entity.material.ChangeLog;
import cn.damei.core.base.service.CrudService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChangeLogService extends CrudService<ChangeLogDao,ChangeLog> {
    public String getChangeVersion(String contractCode){
        StringBuilder returnVersion=new StringBuilder(contractCode);
        String str = entityDao.getChangeVersionTwo(contractCode);
        if(StringUtils.isBlank(str)){
                 returnVersion.append("01") ;
        }else {
            Long changeVersionTwo = Long.parseLong(str)+1L;
            long l = 10L;
            if (changeVersionTwo < l) {
                returnVersion.append('0').append(changeVersionTwo);
            } else {
                returnVersion.append(changeVersionTwo);
            }
        }
        return  returnVersion.toString();
    }

    public List<ChangeLog> findchangeVersionNoByContractNo(String contractCode) {
        return this.entityDao.findChangeVersionNoByContractCode(contractCode);
    }
    /**
     * 根据变更版本号查询变更详情
     * @param changeVersionNo
     * @return
     */
    public List<ChangeLog> findChangeLogByChNo(String changeVersionNo) {
        return this.entityDao.findChangeLogByChNo(changeVersionNo);
    }
    /**
     * 根据变更版本号查询变更单
     * @param changeVersionNo
     */
    public ChangeLog getChangeLogByChNo(String changeVersionNo) {
        return this.entityDao.getChangeLogByChNo(changeVersionNo);
    }
}
