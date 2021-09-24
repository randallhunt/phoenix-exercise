class CreateCredits < ActiveRecord::Migration[6.1]
  def change
    create_table :credits do |t|
      t.integer :client_id
      t.integer :credit_score

      t.timestamps
    end
  end
end
