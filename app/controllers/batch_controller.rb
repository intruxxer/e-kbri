class BatchController < ApplicationController
  
  def index
    require 'win32ole'
    
    path = Rails.root.to_s + "/public"
    
    connection = WIN32OLE.new('ADODB.Connection')
    connection.Open('Provider=Microsoft.Jet.OLEDB.4.0;
                    Data Source=' + path + '/SPRI3.mdb' )
    
    recordset = WIN32OLE.new('ADODB.Recordset')
    recordset.Open("SELECT * FROM tblUser;", connection)                    
    
    @fields = []
    recordset.Fields.each do |field|
            @fields << field.Name
    end                
    
  end
  
end
