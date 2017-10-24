Cucumber::Persona.define "Andy Developer" do
  account = Account.create!(api_key: "ABCDE")
  account.hydrospanners.create!(name: "okayspanner")
end

Cucumber::Persona.define "Betsy Developer" do
  account = Account.create!(api_key: "ZYXWV")
  account.hydrospanners.create!(name: "clearlybetterspanner")
end
