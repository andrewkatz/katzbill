class BillMailer < ActionMailer::Base
  default from: 'no-reply@billsandstuff.com'

  def reminder_email(user, bill)
    @bill = bill

    mail(
      to: user.email,
      subject: "#{bill.days_left} days until \"#{bill.name}\" is due"
    )
  end
end
