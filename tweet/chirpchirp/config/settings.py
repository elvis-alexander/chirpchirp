# APPLICATION CONFIGURATION

# toggles which config variables to use
PRODUCTION = True

# mongodb
MONGO_IP = '192.168.1.88'
MONGO_PORT = 27017

# memcached for mongodb
MEMCACHE_DB_IP = '192.168.1.88'
MEMCACHE_DB_PORT = 11211

if not PRODUCTION:
    MONGO_IP = '127.0.0.1'
    MEMCACHE_DB_IP = '127.0.0.1'
