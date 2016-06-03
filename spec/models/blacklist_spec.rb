require "rails_helper"

RSpec.describe Blacklist, type: :model do
  before :each do
    @joes_glutenfree_pizza = Venue.new(id: 1, google_place_id: "ChIJS3rqSBFawokRLT_XRbu-8r8")
    allow(@joes_glutenfree_pizza).to receive(:save)

    @rachel = Member.new(id: 1, name: "Rachel", uid: 999)
    allow(@rachel).to receive(:save)
  end

  context "Invalid blacklist" do
    it "is invalid without a venue." do
      black_listed_joes = Blacklist.create(member: @rachel)
      expect(black_listed_joes.valid?).to be_falsy
    end

    it "is invalid without a member." do
      black_listed_joes = Blacklist.create(venue: @joes_glutenfree_pizza)
      expect(black_listed_joes.valid?).to be_falsy
    end
  end

  context "Valid blacklist" do
    it "has a venue & user." do
      black_listed_joes = Blacklist.create(venue: @joes_glutenfree_pizza, member: @rachel)
      expect(black_listed_joes.valid?).to be_truthy
    end
  end
end
