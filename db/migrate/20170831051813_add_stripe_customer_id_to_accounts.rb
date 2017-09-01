# frozen_string_literal: true

class AddStripeCustomerIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :stripe_customer_id, :string, null: false
  end
end
