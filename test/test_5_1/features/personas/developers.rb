Cucumber::Persona.define "Developer Alpha" do
  account = Account.create!(api_key: "ABCDE")
  toolbox = account.toolboxes.create!(name: "okaybox")
  toolbox.hydrospanners.create!(name: "okayspanner")
end

Cucumber::Persona.define "Developer Omega" do
  account = Account.create!(api_key: "ZYXWV")
  toolbox = account.toolboxes.create!(name: "clearlybetterbox")
  toolbox.hydrospanners.create!(name: "clearlybetterspanner")
end

Cucumber::Persona.define "Messages Developer" do
  Comlink.create!(token: "123")
end
