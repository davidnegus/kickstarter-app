class CreateTables < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :goal
    end

    create_table :users do |t|
      t.string :name
    end

    create_table :pledges do |t|
      t.integer :amount
      t.integer :user_id
      t.integer :project_id
    end
  end
end
