class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string :title
      t.datetime :limit
      t.string :img
      t.time :notice
      t.references :user
    end
  end
end
