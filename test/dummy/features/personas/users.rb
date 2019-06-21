Cucumber::Persona.define 'Ben Franklin' do
  account = Account.create!
  user = User.create!(email: 'ben@franklin.com', password: 'Password1', account: account)
  toolbox = account.toolboxes.create!(name: 'Okay Toolbox')
  toolbox.hydrospanners.create!(name: 'mediocrehydrospanner')
end

Cucumber::Persona.define 'Martha Washington' do
  account = Account.create!
  User.create!(email: 'martha@washington.com', password: 'Password1', account: account)
  toolbox = account.toolboxes.create!(name: 'besttoolbox')
  toolbox.hydrospanners.create!(name: 'superiorhydrospanner')
end
