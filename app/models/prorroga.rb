class Prorroga < ApplicationRecord
  self.table_name = 'py.prorrogas'
  belongs_to :proyecto
  has_rich_text :txtobs

  #validates :fecha, presence: {message:'Se requiere la fecha'}
  #validates :txtobs, presence: {message:'Se requiere un texto'}

  validate do |prorroga| 
      Valcampos.new(prorroga).vfecha
      Valcampos.new(prorroga).vtxtobs
  end

end

class Valcampos
      def initialize(prorroga)
        @prorroga = prorroga
        @fecha = prorroga.fecha
        @txtobs = prorroga.txtobs
      end

      def vfecha
          if @fecha.nil?
               @prorroga.errors.add :fecha, :invalid, message:"Se requiere la fecha."
          end
      end

      def vtxtobs
          if @txtobs.blank?
               @prorroga.errors.add :txtobs, :invalid, message:"Se requieren las observaciones"
          end
      end
end
