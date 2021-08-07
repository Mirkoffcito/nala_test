class VacationSerializer < ActiveModel::Serializer
  attributes :id, :started_at, :finished_at, :total_days, :state

  belongs_to :employee, serializer: EmployeeSerializer
end
