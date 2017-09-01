ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :account
    column :email
    column :phone
    column :current_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    column :created_at
    column :updated_at
    column :notify_email
    column :notify_sms
    column :notify_push
    column :confirmed_at
    column :confirmation_sent_at
    actions
  end

  filter :email
  filter :phone
  filter :current_sign_in_at
  filter :notify_email
  filter :notify_sms
  filter :notify_push
  filter :confirmed_at
end
