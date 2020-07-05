class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.date :date
      t.integer :amount
      t.integer :loan_id

      t.timestamps
    end
  end
end
