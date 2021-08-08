module ErrorHandler
  extend ActiveSupport::Concern
  included do

    def error_handler
      if params[:employee_id].present? && employee.nil?
        render json: {error: "Employee does not exist"}, status: :not_found
      elsif params[:vacation_id].present? && vacation.nil?
        render json: {error: "Vacation does not exist"}, status: :not_found
      end
    end
  end
end