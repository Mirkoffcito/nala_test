class Fetcher
  # Sets the current state of a vacation
  def self.date_between(start_date, end_date, today)
    if (start_date..end_date).cover?(today)
      'currently'
    elsif start_date>today
      'pending'
    elsif end_date < today
      'finished'
    end
  end

  # Initiates the session
  def self.session
    #@session ||= GoogleDrive::Session.from_service_account_key('./client_secret.json')
    @session ||= GoogleDrive::Session.from_service_account_key(StringIO.new(ENV['CLIENT_SERVICE']))
  end

  # Method used only once to fetch from google sheet to database
  def self.fetch
    spreadsheet = session.spreadsheet_by_title("Vacaciones")
    worksheet = spreadsheet.worksheets.first
    rows = worksheet.rows.drop(1) # Drops the first row (name of columns)
    today = DateTime.now.to_date # fetches current date

    rows.each_with_index do |row, c|
      name = row[0].split(" ") # Array with first_name and last_name
      employee = Employee.create!(first_name:name[0], last_name:name[1])
      vacation = Vacation.create!(
        employee_id:employee.id, 
        started_at:row[1].to_date, 
        finished_at:row[2].to_date, 
        total_days:(row[1].to_date..row[2].to_date).count, 
        state:date_between(row[1].to_date, row[2].to_date, today)
      )
    end
  end
end