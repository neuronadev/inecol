class Persona < ApplicationRecord
  self.table_name='rh.personas'
  belongs_to :tpersona
  has_one :evaluador
  has_one :cargo

  def ap_nom
      return (apaterno||'') + ' ' + (amaterno||'') + ' ' + (nombre||'')
  end

  def ap_nom_prop
    return (apaterno||'').capitalize() + ' ' + (amaterno||'').capitalize() + ' ' + (nombre||'').capitalize()
  end

  def nom_espacio
      n = (nombre||'')
      p = (apaterno||'')
      m = (amaterno||'')

      str_nom = zanityTxt(n) + ' ' + zanityTxt(p) + ' ' + zanityTxt(m)
       #nombre_mod_1 = (apaterno||'').capitalize() + ' ' + (amaterno||'').capitalize() + ' ' + (nombre||'').capitalize() 
       #palabras = nombre_mod_1.split(' ')
       #str_nom = ''
       #palabras.each do |palabra|
       # arry = palabra.split(' ')
       #   if arry.length > 0
       #          arry.each do |p|
       #                 str_nom += p.capitalize()
       #                 str_nom += ' '
       #          end
       #   else
	     #      str_nom += palabra.capitalize()
       #      str_nom += ' '
       #   end   
       #end
     return str_nom  
  end

  def zanityTxt(txt)
    str = ''
    ar_txt = txt.split(' ')
      ar_txt.each do |n|
          str += n.capitalize()
          str += ' '
      end
    return str
  end

end
