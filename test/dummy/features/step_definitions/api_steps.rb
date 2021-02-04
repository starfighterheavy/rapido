Then("the response should be:") do |raw|
  expect(last_response.body.to_s).to eq(raw.to_s)
end