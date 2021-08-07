module StateUpdater
  # Este proceso, si bien ralentiza bastante el request,
  # es necesario para actualizar el estado(currently, pending) de las vacaciones
  # no finalizadas o por empezar, dependiendo del día actual
  def state_updater
    vacations = Vacation.all_except('finished')
    today = DateTime.now.to_date
    vacations.each do |vacation|
      new_state = Fetcher.date_between(vacation.started_at, vacation.finished_at, today)
      if new_state != vacation.state
        vacation.update(state: new_state)
      end
    end
  end
end