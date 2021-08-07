module StateUpdater
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