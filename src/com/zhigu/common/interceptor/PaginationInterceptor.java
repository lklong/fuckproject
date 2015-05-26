package com.zhigu.common.interceptor;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.Set;

import org.apache.ibatis.executor.statement.BaseStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.scripting.defaults.DefaultParameterHandler;

import com.zhigu.model.PageBean;

/**
 * 分页拦截器
 * 
 * @author Hadoop
 * 
 */
/**
 * 拦截器标签声明是一个拦截器，拦截的目标类型是StatementHandler且type只能为借口类型，
 * 拦截的方法是名称为prepare参数为Connection类型的方法
 * 拦截器可用于Executor,ParameterHandler,ResultSetHandler和StatementHandler这些类上
 *
 */
@Intercepts(value = { @Signature(type = StatementHandler.class, method = "prepare", args = { Connection.class }) })
public class PaginationInterceptor implements Interceptor {

	private static String dialect = "mysql";// 数据库类型
	private static String pageSqlId = ".*Page$"; // mybaits的数据库xml映射文件中需要拦截的ID(正则匹配)

	@SuppressWarnings("rawtypes")
	public Object intercept(Invocation ivk) throws Throwable {
		if (ivk.getTarget() instanceof RoutingStatementHandler) {
			RoutingStatementHandler statementHandler = (RoutingStatementHandler) ivk.getTarget();
			BaseStatementHandler delegate = (BaseStatementHandler) ReflectHelper.getValueByFieldName(statementHandler, "delegate");
			MappedStatement mappedStatement = (MappedStatement) ReflectHelper.getValueByFieldName(delegate, "mappedStatement");
			/**
			 * 通过ＩＤ来区分是否需要分页正则表达式<br>
			 * 传入的参数是否有page参数，如果有，则分页，
			 */
			if (mappedStatement.getId().matches(pageSqlId)) { // 拦截需要分页的SQL
				BoundSql boundSql = delegate.getBoundSql();
				Object parameterObject = boundSql.getParameterObject();// 分页SQL<select>中parameterType属性对应的实体参数，即Mapper接口中执行分页方法的参数,该参数不得为空
				if (parameterObject == null) {
					throw new NullPointerException("boundSql.getParameterObject() is null!");
					// return ivk.proceed();
				} else {

					PageBean pageView = null;
					if (parameterObject instanceof PageBean) { // 参数就是Pages实体
						pageView = (PageBean) parameterObject;
					} else if (parameterObject instanceof Map) {
						for (Entry entry : (Set<Entry>) ((Map) parameterObject).entrySet()) {
							if (entry.getValue() instanceof PageBean) {
								pageView = (PageBean) entry.getValue();
								break;
							}
						}
					} else { // 参数为某个实体，该实体拥有Pages属性
						pageView = ReflectHelper.getValueByFieldType(parameterObject, PageBean.class);
						if (pageView == null) {
							return ivk.proceed();
						}
					}
					if (pageView == null) {
						return ivk.proceed();
					}
					String sql = boundSql.getSql();
					Connection connection = (Connection) ivk.getArgs()[0];
					setPageParameter(sql, connection, mappedStatement, boundSql, parameterObject, pageView);
					String pageSql = generatePagesSql(sql, pageView);
					ReflectHelper.setValueByFieldName(boundSql, "sql", pageSql); // 将分页sql语句反射回BoundSql.
				}
			}
		}
		return ivk.proceed();
	}

	/**
	 * 从数据库里查询总的记录数并计算总页数，回写进分页参数<code>PageParameter</code>,这样调用者就可用通过 分页参数
	 * <code>PageParameter</code>获得相关信息。
	 * 
	 * @param sql
	 * @param connection
	 * @param mappedStatement
	 * @param boundSql
	 * @param page
	 * @throws SQLException
	 */
	private void setPageParameter(String sql, Connection connection, MappedStatement mappedStatement, BoundSql boundSql, Object parameterObject, PageBean pageView) throws SQLException {
		// 记录总记录数
		PreparedStatement countStmt = null;
		ResultSet rs = null;
		try {
			String countSql = "select count(1) from (" + sql + ") tmp_count"; // 记录统计
			countStmt = connection.prepareStatement(countSql);
			ReflectHelper.setValueByFieldName(boundSql, "sql", countSql);
			DefaultParameterHandler parameterHandler = new DefaultParameterHandler(mappedStatement, parameterObject, boundSql);
			parameterHandler.setParameters(countStmt);
			rs = countStmt.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = ((Number) rs.getObject(1)).intValue();
			}
			pageView.setTotalRow(count);
		} finally {
			try {
				rs.close();
			} catch (Exception e) {
			}
			try {
				countStmt.close();
			} catch (Exception e) {
			}
		}

	}

	/**
	 * 根据数据库方言，生成特定的分页sql
	 * 
	 * @param sql
	 * @param page
	 * @return
	 */
	private String generatePagesSql(String sql, PageBean page) {
		if (page != null) {
			if ("mysql".equals(dialect)) {
				return buildPageSqlForMysql(sql, page).toString();
			} else if ("oracle".equals(dialect)) {
				return buildPageSqlForOracle(sql, page).toString();
			}
		}
		return sql;
	}

	/**
	 * mysql的分页语句
	 * 
	 * @param sql
	 * @param page
	 * @return String
	 */
	public StringBuilder buildPageSqlForMysql(String sql, PageBean page) {
		StringBuilder pageSql = new StringBuilder(100);
		String beginrow = String.valueOf((page.getPageNo() - 1) * page.getPageSize());
		pageSql.append(sql);
		pageSql.append(" limit " + beginrow + "," + page.getPageSize());
		return pageSql;
	}

	/**
	 * 参考hibernate的实现完成oracle的分页
	 * 
	 * @param sql
	 * @param page
	 * @return String
	 */
	public StringBuilder buildPageSqlForOracle(String sql, PageBean page) {
		StringBuilder pageSql = new StringBuilder(100);
		String beginrow = String.valueOf((page.getPageNo() - 1) * page.getPageSize());
		String endrow = String.valueOf(page.getPageNo() * page.getPageSize());

		pageSql.append("select * from ( select temp.*, rownum row_id from ( ");
		pageSql.append(sql);
		pageSql.append(" ) temp where rownum <= ").append(endrow);
		pageSql.append(") where row_id > ").append(beginrow);
		return pageSql;
	}

	public Object plugin(Object target) {
		return Plugin.wrap(target, this);
	}

	public void setProperties(Properties p) {
		// dialect = p.getProperty("dialect");
		// if (isEmpty(dialect)) {
		// throw new
		// RuntimeException("dialectName or dialect property is not found!");
		// }
		// pageSqlId = p.getProperty("pageSqlId");// 根据id来区分是否需要分页
		// if (isEmpty(pageSqlId)) {
		// throw new RuntimeException("pageSqlId property is not found!");
		// }
	}

	/**
	 * 判断变量是否为空
	 * 
	 * @param s
	 * @return
	 */
	public boolean isEmpty(String s) {
		if (null == s || "".equals(s) || "".equals(s.trim()) || "null".equalsIgnoreCase(s)) {
			return true;
		} else {
			return false;
		}
	}
}
