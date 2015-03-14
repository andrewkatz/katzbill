class CreatePaychecks < ActiveRecord::Migration
  def change
    create_table :paychecks do |t|
      t.string :name
      t.date :pay_date
      t.references :user, index: true
      t.references :account, index: true

      t.timestamps
    end
  end
end
