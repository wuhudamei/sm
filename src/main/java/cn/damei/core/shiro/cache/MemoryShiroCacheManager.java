package cn.damei.core.shiro.cache;

import cn.damei.core.shiro.MemoryManager;
import org.apache.shiro.cache.Cache;

public class MemoryShiroCacheManager implements ShiroCacheManager {

    private MemoryManager memoryManager;

    @Override
    public <K, V> Cache<K, V> getCache(String name) {
        return new MemoryShiroCache<K, V>(name, getMemoryManager());
    }

    @Override
    public void destroy() {
    }

    public MemoryManager getMemoryManager() {
        return memoryManager;
    }

    public void setMemoryManager(MemoryManager memoryManager) {
        this.memoryManager = memoryManager;
    }
}
