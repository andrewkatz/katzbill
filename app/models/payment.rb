class Payment < ActiveRecord::Base
  belongs_to :account

  validates :name, :next_pay_date, :due_on, presence: true

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
    return 'Today' if days == 0

    days_str = [days, 'day'.pluralize(days)].join(' ')
    in_past? ? [days_str, 'ago'].join(' ') : days_str
  end

  def update_next_pay_date
    if next_pay_date
      self.next_pay_date += 1.month
    else
      if Time.zone.now.day > due_on
        self.next_pay_date = (Time.zone.now + 1.month).beginning_of_month
      else
        self.next_pay_date ||= Time.zone.now
      end
    end

    while self.next_pay_date.day < due_on
      break if (self.next_pay_date + 1.day).month != self.next_pay_date.month
      self.next_pay_date += 1.day
    end

    while !allow_weekends && (next_pay_date.saturday? || next_pay_date.sunday?)
      self.next_pay_date -= 1.day
    end

    update_next_pay_date if next_pay_date < Time.zone.now
  end

  private

  def days_left
    today = Time.zone.now.to_date
    next_pay_date = self.next_pay_date.to_date

    return 0 if next_pay_date == today

    if next_pay_date > today
      difference = next_pay_date - today
    else
      difference = today - next_pay_date
    end

    difference.to_i
  end

  def in_past?
    self.next_pay_date.to_date < Time.zone.now.to_date
  end
end
