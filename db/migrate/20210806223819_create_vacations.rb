class CreateVacations < ActiveRecord::Migration[6.1]
  def change
    create_table :vacations do |t|
      t.references :employee, null: false, foreign_key: true
      t.date :started_at, null: false
      t.date :finished_at, null: false
      t.string :state
      t.integer :total_days, null: false

      t.timestamps
    end
  end
end
