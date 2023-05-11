class Persona < ApplicationRecord
  self.table_name='rh.personas'
  belongs_to :tpersona

  def ap_nom
      return (apaterno||'') + ' ' + (amaterno||'') + ' ' + (nombre||'')
  end
end
