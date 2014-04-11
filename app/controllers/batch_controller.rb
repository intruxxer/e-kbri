class BatchController < ApplicationController
  
  @@sisaripath = "/public/SISARI.mdb"  
  
  def syncvisamongotoaccess
    
    dataset = Visa.where(is_sync: 0)
    
    if dataset.count > 0
      
      db = Accessdb.new( Rails.root.to_s + @@sisaripath )
      db.open('imigrasiRI')
      
      dataset.each do |singlerecord|        
        db.execute("INSERT INTO TTVISA(NO_APLIKASI, JENIS, KDPERWAKILAN, NMPERWAKILAN, TGL_DOC, KODE_NEG, WARGA_NEG, NO_PASPOR, TGL_VALID_PASPOR, TGL_KLUAR_PASPOR, KTR_KLUAR_PASPOR, FLAGACCLOKET, NAMA, TGL_LAHIR, TMP_LAHIR, ENTRIES, TGLENTRY, TGL_UPDATE, KD_VISA, Pejabat_ttd, jabatan_ttd) 
        VALUES('" + singlerecord._id.to_s[0,20] + "','I','37A', 'SEOUL', '" + singlerecord.created_at.strftime("%m/%d/%Y") + "','KOR','KOREA, REPUBLIC OF','" + singlerecord.passport_no + "','" + singlerecord.passport_date_expired.to_s + "','" + singlerecord.passport_date_issued.to_s + "','" + singlerecord.passport_issued + "','Y','" + singlerecord.full_name + "','" + singlerecord.dateBirth.strftime("%m/%d/%Y") + "','" + singlerecord.placeBirth + "','" + singlerecord.num_entry + "','" + singlerecord.created_at.strftime("%m/%d/%Y") + "','" + singlerecord.updated_at.strftime("%m/%d/%Y") + "','Biasa','Bambang Witjaksono','COUNSELLOR')")
      end
      
      db.close
      
      dataset.update(is_sync: 1)
      
    end    
    
  end
  
  def reversesyncvisamongotoaccess
    
      db = Accessdb.new( Rails.root.to_s + @@sisaripath )
      db.open('imigrasiRI')
      
      dataset = Visa.where(is_sync: 0).order_by(updated_at: 'asc')
      db.query("SELECT * FROM TTVISA WHERE TGL_AW_VISA IS NOT NULL AND TGLENTRY >= #" + dataset.first.created_at.strftime("%m/%d/%Y") + "#")
      
      rows = db.data
      if rows.count > 0
        #syncbackhere
        rows.each do |singlerecord|
          
        end
          
      end  
      
      db.close  
        
  end
  
end
