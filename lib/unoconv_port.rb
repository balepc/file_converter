class UnoconvPort

  PORTS = ['2002', '2003', '2004', '2005', '2006']

  def self.port
    PORTS[rand(5)]
  end

end