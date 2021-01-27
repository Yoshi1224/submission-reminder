class AddCompletedAndSoOnToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :completed, :boolean
    add_column :submissions, :star, :boolean
    add_column :submissions, :due_date, :date
  end
end
