class PaymentService
  def initialize(stay:)
    @stay = stay
    @first_day = stay.start_date
    @last_day = stay.end_date
    @studio_monthly_price = stay.studio.monthly_price
  end

  def create_monthly_payments # I chose not to work on the date range to avoid creating and manipulating a potentially big array, although it could have been clearer/easier
    if @first_day.beginning_of_month == @last_day.beginning_of_month # I do not compare months only in order to avoid any mistake due to a stay starting and finishing in the same month on different years
      create_prorated_payment_between(
        payment_start_date: @first_day,
        payment_end_date: @last_day
      )
    else
      create_prorated_payment_between(
        payment_start_date: @first_day,
        payment_end_date: @first_day.next_month.beginning_of_month # To make sure we bill the last night of the month
      )
      current_payment_date = @first_day.next_month.beginning_of_month
      until current_payment_date == @last_day.beginning_of_month
        @stay.payments.create(
          date: current_payment_date,
          price: @studio_monthly_price
        )
        current_payment_date += 1.month
      end
      unless @last_day.day == 1 # To make sure we do not create an extra 0€ payment if the stay finishes on the first day of the month
        create_prorated_payment_between(
          payment_start_date: @last_day.beginning_of_month,
          payment_end_date: @last_day
        )
      end
    end
  end

  private

  def create_prorated_payment_between(payment_start_date:, payment_end_date:)
    @stay.payments.create(
      date: payment_start_date.beginning_of_month,
      price: calculate_prorated_price(payment_start_date, payment_end_date)
    )
  end

  def calculate_prorated_price(payment_start_date, payment_end_date)
    number_of_nights = (payment_end_date - payment_start_date).to_i
    nights_in_month = payment_start_date.end_of_month.day

    (number_of_nights.to_f / nights_in_month.to_f * @studio_monthly_price.to_f).to_i # I assume we do not want to deal with cents but I may be wrong
  end
end
