class Bill < ActiveRecord::Base
  belongs_to :user

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
    today = Date.current

    return 'Today' if self.due_date == today

    if self.due_date > today
      difference = self.due_date - today
    else
      difference = today - self.due_date
    end

    difference = difference.to_i
    [difference, 'day'.pluralize(difference)].join(' ')
  end
end
