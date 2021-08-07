class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy

  scope :on_vacation, ->(state) { Employee.includes(:vacations).where(Employee.vacations.state) }
  
end
