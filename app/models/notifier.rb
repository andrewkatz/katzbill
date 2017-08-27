class Notifier
  def title(bill)
    "#{bill.days_left} #{'day'.pluralize(bill.days_left)} until #{bill.name} is due"
  end

  def message(bill)
    "Due on #{bill.next_pay_date.strftime('%B %-d')}"
  end
end
