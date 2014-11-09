class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bills, through: :account
  belongs_to :account

  before_validation :ensure_account

  attr_accessor :invite_token

  private

  def ensure_account
    return if account.present?

    if @invite_token.present?
      account = Account.where(token: @invite_token).first
      if account.present?
        self.account = account
      else
        errors.add 'invite_token', 'is not valid'
      end
    else
      self.account = Account.create
    end
  end
end
