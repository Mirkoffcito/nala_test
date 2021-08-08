class Vacation < ApplicationRecord
  belongs_to :employee

  enum state: { finished: 'finished', pending: 'pending', currently:'currently' }

  # Vacation.all_except('finished') -> Returns all the vacations that will require change depending on current date
  scope :all_except, ->(state) { where.not(state:state) }
  scope :by_state, -> (state) { where(state: "#{state}") }
  scope :by_start_date, -> (from, to) { where("started_at BETWEEN ? AND ?", from.to_date, to.to_date) }
  scope :by_end_date, -> (from, to) { where("finished_at BETWEEN ? AND ?", from.to_date, to.to_date) }

  after_create :create_new_row

  private 

  def create_new_row
    spreadsheet = Fetcher.session.spreadsheet_by_title("Vacaciones")
    worksheet = spreadsheet.worksheets.first
    name = self.employee.first_name + " " + self.employee.last_name
    new_row = [name, self.started_at.to_s, self.finished_at.to_s]
    worksheet.insert_rows(worksheet.num_rows+1, [new_row])
    worksheet.save
  end
end
