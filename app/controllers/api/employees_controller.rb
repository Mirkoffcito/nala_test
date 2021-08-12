module Api
  class EmployeesController < ApplicationController

    def index
      @employees = Employee.all
      paginate @employees, per_page: 10, each_serializer: EmployeesSerializer
    end

    def show
      render json: employee, serializer: EmployeesSerializer, status: :ok
    end

    def create
      @employee = Employee.new(employee_params)
      if @employee.save
        render json: @employee, serializer: EmployeeSerializer, status: :created
      else
        render json: @employee.errors
      end
    end

    def update
      if employee.update(employee_params)
        render json: @employee, serializer: EmployeesSerializer, status: :ok
      else
        render json: @employee.errors, status: :bad_request
      end
    end

    def destroy
      employee.destroy
    end

    private
    
    def employee
      @employee = Employee.find_by(id: params[:employee_id])
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name)
    end
  end
end
