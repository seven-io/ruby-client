class EnvKeyStore
  def initialize(key)
    @key = "SMS77_TEST_#{key}"

    @store = ENV[@key]
  end

  def get(fallback = nil)
    @store.nil? ? fallback : @store
  end

  def set(val, only_on_nil = false)
    @store = val unless only_on_nil
  end
end