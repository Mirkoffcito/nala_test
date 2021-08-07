module Api
  class SpreadsheetsController < ApplicationController
    before_action :session, only: [:fetch]

    def date_between(start_date, end_date, today)
      (start_date..end_date).cover?(today)
    end

    def fetch
      spreadsheet = @session.spreadsheet_by_title("Vacaciones")
      worksheet = spreadsheet.worksheets.first
      rows = worksheet.rows.drop(1)
      today = DateTime.now.to_date
      rows.each_with_index do |row, c|
        name = row[0].split(" ")
        employee = Employee.create!(first_name:name[0], last_name:name[1])
        vacation = Vacation.create!(employee_id:employee.id, started_at:row[1].to_date, finished_at:row[2].to_date, total_days:(row[1].to_date..row[2].to_date).count, on_course:date_between(row[1], row[2], today))
      end
      render json: Employee.all
    end
  end
end