class Symbol
  #=======================================
  # Symbol#>>
  #=======================================
  def >> other
    lambda do |obj, *args|
      other.to_proc.call self.to_proc.call(obj, *args)
    end
  end

end
