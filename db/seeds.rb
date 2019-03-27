# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating tenants'

tenants = Tenant.create(
  [
    { email: 'pierre-letudiant@foobar.com' },
    { email: 'paul-le-voyageur@foobar.com' },
    { email: 'jacques-le-divorcé@foobar.com' }
  ]
)

puts 'Creating studios'

studios ||= Studio.create(
  [
    { name: 'Defense', monthly_price: 1000 },
    { name: 'Arsenal',  monthly_price: 800 },
    { name: 'Lazare', monthly_price: 850 },
    { name: 'Ferney', monthly_price: 1100 }
  ]
)

puts 'Creating stays'

tenants.each do |tenant|
  studio = studios.pop
  start_date = Date.current + (1 .. 30).to_a.sample.days
  end_date = start_date + (31 .. 365).to_a.sample.days
  tenant.stays.create(studio: studio, start_date: start_date, end_date: end_date)
end

puts 'Creating discounts'

tenants.each do |tenant|
  discounted_stay = tenant.stays.first
  stay_duration_in_nights = (discounted_stay.end_date - discounted_stay.start_date).to_i
  discount_start_date = discounted_stay.start_date + (1 .. stay_duration_in_nights).to_a.sample.days
  discount_end_date = discount_start_date + (1 .. 120).to_a.sample.days # The discount can eventually run after the stay end date, which could be an incentive for him to stay longer
  discounted_stay.discounts.create(
    start_date: discount_start_date,
    end_date: discount_end_date,
    discount_percentage_value: [20, 30, 40].sample
  )
end
