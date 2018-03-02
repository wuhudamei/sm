package cn.damei.core.shiro.cache;

import cn.damei.core.shiro.JedisManager;
import cn.mdni.commons.serialize.SerializeUtils;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.Set;

public class JedisShiroCache<K, V> implements Cache<K, V> {

	private static final String REDIS_SHIRO_CACHE = "shiro-cache:";

	private JedisManager jedisManager;

	private String name;

	private Logger logger = LoggerFactory.getLogger(JedisShiroCache.class);

	public JedisShiroCache(String name, JedisManager jedisManager) {
		this.name = name;
		this.jedisManager = jedisManager;
	}

	/**
	 * 自定义relm中的授权/认证的类名加上授权/认证英文名字
	 */
	public String getName() {
		if (name == null)
			return "";
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@SuppressWarnings("unchecked")
	@Override
	public V get(K key) throws CacheException {
		byte[] byteKey = SerializeUtils.serialize(buildCacheKey(key));
		byte[] byteValue = new byte[0];
		try {
			byteValue = jedisManager.getValueByKey(byteKey);
		} catch (Exception e) {
			logger.warn("get cache error", e);
		}
		return (V) SerializeUtils.deserialize(byteValue);
	}

	@Override
	public V put(K key, V value) throws CacheException {
		V previos = get(key);
		try {
			jedisManager.saveValueByKey(SerializeUtils.serialize(buildCacheKey(key)), SerializeUtils.serialize(value),
					-1);
		} catch (Exception e) {
			logger.warn("put cache error", e);
		}
		return previos;
	}

	@Override
	public V remove(K key) throws CacheException {
		V previos = get(key);
		try {
			jedisManager.deleteByKey(SerializeUtils.serialize(buildCacheKey(key)));
		} catch (Exception e) {
			logger.warn("remove cache error", e);
		}
		return previos;
	}

	@Override
	public void clear() throws CacheException {
		// TODO
	}

	@Override
	public int size() {
		if (keys() == null)
			return 0;
		return keys().size();
	}

	@Override
	public Set<K> keys() {
		// TODO
		return null;
	}

	@Override
	public Collection<V> values() {
		// TODO
		return null;
	}

	private String buildCacheKey(Object key) {
		return REDIS_SHIRO_CACHE + getName() + ":" + key;
	}

}
