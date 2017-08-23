class Payment < ActiveRecord::Base
  belongs_to :account

  validates :name, :next_pay_date, :due_on, presence: true

  before_save :match_due_on, if: :due_on_changed?

  def pay
    self.last_paid_date = Time.zone.now
    update_next_pay_date
  end

  def pay!
    pay
    save!
  end

  def friendly_days_left
    days = days_left
    return 'Today' if days.zero?

    days_str = [days, 'day'.pluralize(days)].join(' ')
    in_past? ? [days_str, 'ago'].join(' ') : days_str
  end

  def update_next_pay_date
    if next_pay_date
      self.next_pay_date += 1.month
    else
      set_next_pay_date
    end

    adjust_next_pay_date
    update_next_pay_date if in_past?
  end

  def days_left
    today = Time.zone.now.to_date
    next_pay_date = self.next_pay_date.to_date

    return 0 if next_pay_date == today

    difference = if next_pay_date > today
                   next_pay_date - today
                 else
                   today - next_pay_date
                 end

    difference.to_i
  end

  private

  def match_due_on
    set_next_pay_date
    adjust_next_pay_date
  end

  def set_next_pay_date
    now = Time.zone.now
    self.next_pay_date = now
    self.next_pay_date += 1.month if now.day > due_on
  end

  def adjust_next_pay_date
    last_day_of_month = self.next_pay_date.end_of_month.day
    day = [due_on, last_day_of_month].min
    self.next_pay_date = Time.zone.local(next_pay_date.year, next_pay_date.month, day)

    self.next_pay_date -= 1.day while !allow_weekends && weekend?
  end

  def in_past?
    self.next_pay_date.to_date < Time.zone.now.to_date
  end

  def weekend?
    next_pay_date.saturday? || next_pay_date.sunday?
  end
end
