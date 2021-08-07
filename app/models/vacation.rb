class Vacation < ApplicationRecord
  belongs_to :employee

  enum state: { finished: 'finished', pending: 'pending', currently:'currently' }

  # Vacation.all_except('finished') -> Returns all the vacations that will require change depending on current date
  scope :all_except, ->(state) { where.not(state:state) }
end
