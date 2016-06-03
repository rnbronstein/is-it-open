require "rails_helper"

RSpec.describe Venue, type: :model do
  it "has a name." do
    spock = Author.create(status: "Admin")
    expect(spock.valid?).to be_falsy
  end

  it "has a status." do
    spock = Author.create(name: "Spock", status: "Admin")
    expect(spock.status).to be_truthy
  end
end
