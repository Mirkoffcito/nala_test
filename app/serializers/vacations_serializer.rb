class VacationsSerializer < ActiveModel::Serializer
  attributes :id, :state, :started_at, :finished_at, :total_days
  
  belongs_to :employee
end
