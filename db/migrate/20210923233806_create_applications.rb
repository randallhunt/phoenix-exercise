class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.integer :client_id
      t.integer :annual_income
      t.integer :monthly_debt
      t.timestamps
    end
  end
end
