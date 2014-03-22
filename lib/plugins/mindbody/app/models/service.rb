class Service
  
  @@url = "https://api.mindbodyonline.com/0_5/"
  
  @@site_credentials={'SourceCredentials'=>YAML.load_file("config/mindbody.yml")}
  
  def initialize
    @client = Savon.client(wsdl: @@url+"#{self.class}.asmx?WSDL")
    self
  end
  
  
  def method_missing(method, *args, &block)
    if(@client.operations.include?method)
      msg = args.first || {}
      resp = @client.call(method, message: {'Request'=>@@site_credentials.merge(msg)})
      resp.doc.remove_namespaces!
      resp
    else
      super
    end
  end
  
  def operations
    @client.operations
  end
  
  def methods
    super + operations
  end
end
