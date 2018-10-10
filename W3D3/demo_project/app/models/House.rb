class House < ActiveRecord::Base
  validates :address, presence: true

  has_many :residents,
    primary_key: :id,
    foreign_key: :house_id,
    class_name: :Person

  # def person
  #   Person.where(house_id: self.id)
  # end
end
