class AddAllowWeekendsToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :allow_weekends, :boolean, default: false
  end
end
