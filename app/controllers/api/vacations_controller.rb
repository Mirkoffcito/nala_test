module Api
  class VacationsController < ApplicationController
    before_action :state_updater, only: [:index, :show]

    def index
      @vacations = Vacation.all
      render json: @vacations
    end

    def show
    end

    def create
      @vacation = Vacation.new(vacation_params)
      @vacation.assign_attributes(employee_id: params[:employee_id])
      assign_state_and_total_days(@vacation)
      # create_new_row_in_gsheet
    end

    def update
    end

    def delete
    end

    private

    def vacation
      @vacation ||= Vacation.find(params[:id])
    end

    def vacation_params
      params.require(:vacation).permit(:started_at, :finished_at)
    end
  end
end
