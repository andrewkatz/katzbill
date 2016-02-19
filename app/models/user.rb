class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :payments, through: :account
  has_many :bills, through: :account
  has_many :paychecks, through: :account
  belongs_to :account

  before_validation :ensure_account
  before_validation :ensure_calendar_token

  validates :calendar_token, presence: true

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

  def ensure_calendar_token
    self.calendar_token = SecureRandom.urlsafe_base64(16) unless calendar_token?
  end
end
