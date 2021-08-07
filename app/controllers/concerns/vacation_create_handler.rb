module VacationCreateHandler
  def assign_state_and_total_days(vacation)
    @vacation = vacation
    if @vacation.started_at < @vacation.finished_at
      today = DateTime.now.to_date
      state = Fetcher.date_between(@vacation.started_at, @vacation.finished_at, today)
      total_days = (@vacation.started_at..@vacation.finished_at).count
      @vacation.assign_attributes(state: state, total_days: total_days)
      if @vacation.save
        # create_new_row_in_gsheet
        render json: @vacation, serializer: VacationSerializer, status: :ok
      else
        render json: @vacation.errors, status: :bad_request
      end
    else
      render json: {error: "Unvalid dates"}, status: :bad_request
    end
  end
end