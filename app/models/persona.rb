class Persona < ApplicationRecord
  self.table_name='rh.personas'
  belongs_to :tpersona

  def ap_nom
      return (apaterno||'') + ' ' + (amaterno||'') + ' ' + (nombre||'')
  end

  def ap_nom_prop
    return (apaterno||'').capitalize() + ' ' + (amaterno||'').capitalize() + ' ' + (nombre||'').capitalize()
  end

end
