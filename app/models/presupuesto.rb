class Presupuesto < ApplicationRecord
  self.table_name = 'py.presupuestos'
  belongs_to :proyecto
  belongs_to :moneda
  has_many :solicitados, dependent: :destroy, inverse_of: :presupuesto
  accepts_nested_attributes_for :solicitados, reject_if: :all_blank, allow_destroy: true

  validates :costo, presence: true
  validates :moneda_id, presence: true
  validates :solicitados, presence: true
  
   validate do |presupuesto|
        SumCap.new(presupuesto).validate
   end


end

class SumCap
     def initialize(prep)
         @prep = prep
     end
     def validate
         suma = 0.0
         if !@prep.solicitados.nil?
                @prep.solicitados.each do |item|
                       if !item.monto.nil? && item._destroy == false
                              suma += item.monto
                       end
                end
         end
         if @prep.tgastos != suma
              @prep.errors.add :base, :invalid, message:"La suma total de los capitulos debe ser igual al total para gastos."
         end     
     end
end