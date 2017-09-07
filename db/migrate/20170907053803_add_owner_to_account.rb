class AddOwnerToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :owner, references: :users, index: true
  end
end
