class Employee < ApplicationRecord
  has_many :vacations, dependent: :destroy

  #scope :on_vacation, ->  { (Employee.on_vacation) }
  #scope :working, -> { (Employee.working) }
  
  def self.on_vacation
    employees = Employee.all
    @on_vacation = Array.new
    employees.each do |employee|
      if employee.vacations.currently.present?
        @on_vacation.append(employee)
      end
    end
    @on_vacation
  end

  def self.working
    employees = Employee.all
    @working = Array.new
    employees.each do |employee|
      if employee.vacations.currently.blank?
        @working.append(employee)
      end
    end
    @working
  end
end
