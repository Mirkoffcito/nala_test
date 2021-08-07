module Api
  class EmployeesController < ApplicationController

    def index
      @employees = Employee.all
      render json: @employees
    end

    def show
    end

    def create
    end

    def update
    end

    def delete
    end

  end
end
