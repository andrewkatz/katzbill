class Bill < ActiveRecord::Base
  REMINDER_INTERVALS = [0, 3, 7].freeze

  belongs_to :account

  validates :name, :due_date, presence: true

  default_scope { order(:due_date) }

  def pay
    self.due_date += 1.month
  end

  def pay!
    pay
    save!
  end

  def days_left
    return 'Today' if days == 0

    [days, 'day'.pluralize(days)].join(' ')
  end

  def should_send_reminder?
    REMINDER_INTERVALS.include? days
  end

  private

  def days
    today = Date.current

    return 0 if self.due_date == today

    if self.due_date > today
      difference = self.due_date - today
    else
      difference = today - self.due_date
    end

    difference.to_i
  end
end
