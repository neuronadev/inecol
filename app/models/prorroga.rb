class Prorroga < ApplicationRecord
  self.table_name = 'py.prorrogas'
  belongs_to :proyecto
  has_rich_text :txtobs

  validates :fecha, presence: true
  validates :txtobs, presence: true

 # validate do |prorroga| 
 #     Valcampos.new(prorroga).vfecha
 #     Valcampos.new(prorroga).vtxtobs
 # end

end

class Valcampos
      def initialize(prorroga)
        @prorroga = prorroga
        @fecha = prorroga.fecha
        @txtobs = prorroga.txtobs
        puts "AAAAAAAAAA"
        puts @txtobs.to_s
      end

      def vfecha
          if @fecha.nil?
               @prorroga.errors.add :base, :invalid, message:"Se requiere la fecha."
          end
      end

      def vtxtobs
          if @txtobs.to_s.nil?
               @prorroga.errors.add :base, :invalid, message:"Se requieren las observaciones"
          end
      end
end
