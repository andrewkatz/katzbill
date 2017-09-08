class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  has_many :payments, through: :account
  has_many :bills, through: :account
  has_many :paychecks, through: :account
  belongs_to :account

  before_validation :ensure_account
  before_validation :ensure_calendar_token
  after_destroy :destroy_account
  after_create :set_account_owner

  validates :calendar_token, presence: true
  validates :phone, phone: { possible: true, allow_blank: true }

  attr_accessor :invite_token

  scope :notifiable_by_email, -> { where(notify_email: true) }
  scope :notifiable_by_sms, -> { where(notify_sms: true).where.not(phone: nil) }
  scope :notifiable_by_push, -> { where(notify_push: true).where.not(pushover_user_key: nil) }

  before_save :clean_phone

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

  def set_account_owner
    account.update! owner: self if account.owner.nil?
  end

  def ensure_calendar_token
    self.calendar_token = SecureRandom.urlsafe_base64(16) unless calendar_token?
  end

  def clean_phone
    return if !phone_changed? || phone.blank?

    self.phone = Phonelib.parse(phone).sanitized
  end

  def destroy_account
    account.destroy if account.owner == self
  end
end
