class AddNotificationPreferencesToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :notify_email, default: true
      t.boolean :notify_push, default: false
      t.boolean :notify_sms, default: false
      t.string :phone
    end
  end
end
