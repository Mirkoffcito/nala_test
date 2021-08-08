class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy
end
