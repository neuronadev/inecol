class Prorroga < ApplicationRecord
  self.table_name = 'py.prorrogas'
  belongs_to :proyecto
  has_rich_text :txtobs

  validates :fecha, presence: true
end
