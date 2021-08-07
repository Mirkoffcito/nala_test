class EmployeesSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :on_vacation

  def on_vacation
    if object.vacations.currently.blank? # Si la lista de vacaciones en curso del usuario está en blanco, no esta de vacaciones
      false
    else
      true
    end
  end
end
