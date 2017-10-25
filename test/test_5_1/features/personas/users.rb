Cucumber::Persona.define "Ben Franklin" do
  account = Account.create!
  User.create!(email: 'ben@franklin.com', password: 'Password1', account: account)
  account.toolboxes.create!(name: 'Okay Toolbox')
end
