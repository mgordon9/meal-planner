class Meal < ApplicationRecord
  belongs_to :schedule
  has_many :foods, dependent: :destroy
end
