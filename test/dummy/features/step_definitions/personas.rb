Given /I am ([a-zA-Z]+ [a-zA-z]+)/ do |name|
  Cucumber::Persona.find(name).create
end

Given /([a-zA-Z]+ [a-zA-z]+) exists/ do |name|
  Cucumber::Persona.find(name).create
end
