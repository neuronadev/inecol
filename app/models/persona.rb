class Persona < ApplicationRecord
  self.table_name='rh.personas'
  belongs_to :tpersona

  def ap_nom
      return (apaterno||'') + ' ' + (amaterno||'') + ' ' + (nombre||'')
  end

  def ap_nom_prop
    return (apaterno||'').capitalize() + ' ' + (amaterno||'').capitalize() + ' ' + (nombre||'').capitalize()
  end

  def nom_espacio
       nombre_mod_1 = (apaterno||'').capitalize() + ' ' + (amaterno||'').capitalize() + ' ' + (nombre||'').capitalize() 
       palabras = nombre_mod_1.split(' ')
       str_nom = ''
       palabras.each do |palabra|
	           str_nom += palabra.capitalize()
             str_nom += ' '
       end
     return str_nom  
  end

end
