class Protocolo < ApplicationRecord
  self.table_name = 'py.protocolos'
  belongs_to :proyecto
  has_one_attached :dprotocolo

  #validates :dprotocolo, presence: true
  
end
