module Api
  class VacationsController < ApplicationController
    before_action :state_updater, only: [:index, :show]
    before_action :error_handler, only: [:show, :update, :destroy, :index]

    # /api/vacations?by_state=pending
    has_scope :by_state

    # /api/vacations?by_start_date[from]=2020-01-01&by_start_date[to]=2021-01-01
    has_scope :by_start_date, using: %i[from to], type: :hash
    has_scope :by_end_date, using: %i[from to], type: :hash

    def index
      #@vacations = apply_scopes(Vacation.all.includes(:employee))
      #paginate @vacations, per_page: 10, each_serializer: VacationsSerializer
      paginate vacations, per_page: 10, each_serializer: VacationsSerializer
    end

    def show
      render json: vacation, serializer: VacationSerializer
    end

    def create
      @vacation = Vacation.new(vacation_params)
      @vacation.assign_attributes(employee_id: params[:employee_id])
      assign_state_and_total_days(@vacation)
    end

    def update
      vacation.assign_attributes(vacation_params)
      assign_state_and_total_days(@vacation)
    end

    def destroy
      vacation.destroy
    end

    private
    
    def vacations
      if params[:employee_id].present?
        @vacations = apply_scopes(employee.vacations.includes(:employee))
      else
        @vacations = apply_scopes(Vacation.all.includes(:employee))
      end
    end

    def employee
      @employee ||= Employee.find_by(id: params[:employee_id])
    end

    def vacation
      if params[:employee_id].present?
        @vacation ||= employee.vacations.includes(:employee).find_by(id: params[:vacation_id])
      else
        @vacation ||= Vacation.includes(:employee).find_by(id: params[:vacation_id])
      end
    end

    def vacation_params
      params.require(:vacation).permit(:started_at, :finished_at)
    end
  end
end
