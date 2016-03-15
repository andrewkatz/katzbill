class AddAutopayToBills < ActiveRecord::Migration
  def change
    add_column :payments, :autopay, :boolean, default: false
  end
end
