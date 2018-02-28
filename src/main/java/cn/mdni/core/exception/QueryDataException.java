package cn.mdni.core.exception;

/**
 * <dl>
 * <dd>描述: </dd>
 * <dd>公司: 美得你信息技术有限公司</dd>
 * <dd>创建时间：15/8/11  下午3:53</dd>
 * <dd>创建人： weiys</dd>
 * </dl>
 */
@SuppressWarnings("all")
public class QueryDataException extends Exception{

    public QueryDataException(String message) {
        super( message );
    }

    public QueryDataException() {
        super();
    }

    public QueryDataException(String message, Throwable cause) {
        super( message, cause );
    }

    public QueryDataException(Throwable cause) {
        super( cause );
    }
}
