class Array
  #=======================================
  # Array#symbolize
  #=======================================
  def symbolize
    self.inject([]){|arr, val|
      val = val.symbolize if val.respond_to? :symbolize
      arr.push val
    }
  end
end
