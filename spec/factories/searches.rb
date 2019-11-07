FactoryBot.define do
  factory :search do
    url { Faker::Internet.url(host: 'https://www.mysterious-url.com', path: "/#{Faker::Superhero.unique.power}")}
  end
end
