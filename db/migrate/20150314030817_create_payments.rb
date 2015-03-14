class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.datetime :last_paid_date
      t.datetime :next_pay_date
      t.string :url
      t.string :type
      t.references :account, index: true
      t.integer :due_on

      t.timestamps
    end
  end
end
