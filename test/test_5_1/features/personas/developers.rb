Cucumber::Persona.define "Andy Developer" do
  puts "Creating Andy"
  account = Account.create!(api_key: "ABCDE")
  toolbox = account.toolboxes.create!(name: "okaybox")
  toolbox.hydrospanners.create!(name: "okayspanner")
end

Cucumber::Persona.define "Betsy Developer" do
  puts "Creating Betsy"
  account = Account.create!(api_key: "ZYXWV")
  toolbox = account.toolboxes.create!(name: "clearlybetterbox")
  toolbox.hydrospanners.create!(name: "clearlybetterspanner")
end
