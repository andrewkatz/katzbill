class DropPaychecksAndBills < ActiveRecord::Migration
  def change
    drop_table :bills
    drop_table :paychecks
  end
end
