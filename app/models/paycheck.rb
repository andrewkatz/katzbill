class Paycheck < ActiveRecord::Base
  belongs_to :account

  default_scope { order(:pay_date) }

  def pay
    self.pay_date += 1.month
  end

  def pay!
    pay
    save!
  end

  def days_left
    return 'Today' if days == 0

    days_str = [days, 'day'.pluralize(days)].join(' ')
    in_past? ? [days_str, 'ago'].join(' ') : days_str
  end

  private

  def days
    today = Date.current

    return 0 if self.pay_date == today

    if self.pay_date > today
      difference = self.pay_date - today
    else
      difference = today - self.pay_date
    end

    difference.to_i
  end

  def in_past?
    today = Date.current

    self.pay_date < today
  end
end
