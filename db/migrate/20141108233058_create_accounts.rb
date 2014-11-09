class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :token
    end

    add_reference :bills, :account, index: true
    add_reference :users, :account, index: true
  end
end
