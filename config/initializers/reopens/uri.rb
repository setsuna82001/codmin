module URI
  class << self
    def normalurl str
      # set variables
      data    = parse str
      scheme  = data.scheme
      host    = data.host
      port    = data.port
      path    = data.path

      # case check
      hostname  = case true
      when scheme == 'http'   && port == 80   then host
      when scheme == 'https'  && port == 443  then host
      else "#{host}:#{port}"
      end

      # set url
      url   = "#{scheme}://#{hostname}#{path}"
    end
  end
end
