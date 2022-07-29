class Schedule < ApplicationRecord
  has_many :meals, dependent: :destroy
end
