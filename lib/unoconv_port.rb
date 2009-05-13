class UnoconvPort

  PORTS = ['2002', '2003', '2004']

  def self.port
    PORTS[rand(3)]
  end

end