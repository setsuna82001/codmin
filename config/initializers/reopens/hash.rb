class Hash
  #=======================================
  # Hash#regist
  #=======================================
  def regist key, val
    obj = self.dup
    obj.store key, val
    return obj
  end

  #=======================================
  # Hash#regist!
  #=======================================
  def regist! key, val
    self.store key, val
    return self
  end

  #=======================================
  # Hash#symbolize
  #=======================================
  def symbolize
    self.inject([]){|arr, (key, val)|
      key = key.to_sym    if key.respond_to? :to_sym
      val = val.symbolize if val.respond_to? :symbolize
      arr.push [key, val]
    }.to_h
  end
end
