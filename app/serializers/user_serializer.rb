class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :pushover_user_key

  has_one :account, embed: :ids
end
