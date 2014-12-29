class AddPayUrlToBill < ActiveRecord::Migration
  def change
    add_column :bills, :pay_url, :string
  end
end
