FactoryBot.define do
  factory :tenant do
    email { "johndoe@example.com" }
  end

  factory :studio do
    name { "Lazare" }
  end

  factory :stay do
    start_date { Date.current }
    end_date { Date.current + 1.month }
    tenant
    studio
  end
end
