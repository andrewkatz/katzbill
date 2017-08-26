class BillMailer < ActionMailer::Base
  default from: 'no-reply@billsandstuff.com'

  def reminder_email(bill)
    @bill = bill

    mail(
      to: bill.account.users.map(&:email),
      subject: "#{bill.days_left} days until \"#{bill.name}\" is due"
    )
  end
end
