class Cache
  @@CACHE = {}

  def self.has_key? key
    @@CACHE.has_key? key
  end

  def self.store(key, value)
    @@CACHE.store(key, value)
  end

  def self.fetch key
    @@CACHE.fetch key
  end
end

