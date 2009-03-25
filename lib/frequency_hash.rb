class FrequencyHash < Hash
  
  def occur(key)
    if include?(key)
      store(key, self[key] + 1)
    else
      store(key, 1)
    end
  end
  
  def frequent_keys(min_frequency)
    self.keys.reject{|key| self[key] < min_frequency}.sort{|a,b| self[b] <=> self[a] && a <=> b}
  end
  
end