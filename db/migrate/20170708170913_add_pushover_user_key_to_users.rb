class AddPushoverUserKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pushover_user_key, :string
  end
end
