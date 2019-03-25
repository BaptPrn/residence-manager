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
