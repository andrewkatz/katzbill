class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_paid_date, :next_pay_date, :url, :due_on, :created_at, :updated_at,
    :payment_type

  has_one :account, embed: :ids

  def payment_type
    object.class.to_s.downcase
  end
end
