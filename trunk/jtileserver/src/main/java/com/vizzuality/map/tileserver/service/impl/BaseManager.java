/**
 * 
 */
package com.vizzuality.map.tileserver.service.impl;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.google.inject.Inject;

/**
 * Base of all manager implementations that use iBatis for ORM
 * Utility methods provided to ensure that sessions are handled gracefully
 * @author tim
 */
public class BaseManager {
	@Inject
	protected SqlSessionFactory sqlSessionFactory;
	
	/**
	 * @param type The return type 
	 * @param sqlKey The iBatis SQL key
	 * @param parameter To select with
	 * @return The casted result
	 * @throws IOException On error
	 */
	@SuppressWarnings("unchecked")
	protected <T> T selectOne(Class<T> type, String sqlKey, Object parameter) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return (T) session.selectOne(sqlKey, parameter);
		} finally {
			session.close();
		}
	}
	
	protected Integer selectOneAsInt(String sqlKey) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return (Integer) session.selectOne(sqlKey);
		} finally {
			session.close();
		}
	}
	
	@SuppressWarnings("unchecked")
	protected <E> List<E> list(Class<E> type, String sqlKey) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return (List<E>) session.selectList(sqlKey);
		} finally {
			session.close();
		}
	}	
	
	@SuppressWarnings("unchecked")
	protected <E> List<E> list(Class<E> type, String sqlKey, Object param) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return (List<E>) session.selectList(sqlKey,param);
		} finally {
			session.close();
		}
	}	
	
	@SuppressWarnings("unchecked")
	protected <E> List<E> list(Class<E> type, String sqlKey, int count) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			return (List<E>) session.selectList(sqlKey, count);
		} finally {
			session.close();
		}
	}	

	protected void insert(String sqlKey, Object object) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			session.insert(sqlKey, object);
		} finally {
			session.close();
		}
	}	
	
	protected void update(String sqlKey, Object object) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			session.update(sqlKey, object);
		} finally {
			session.close();
		}
	}	

	protected void delete(String sqlKey, Object object) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			session.delete(sqlKey, object);
		} finally {
			session.close();
		}
	}	

}
