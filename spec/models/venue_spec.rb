require "rails_helper"

RSpec.describe Venue, type: :model do
  context "Invalid venue" do
    it "is invalid without a place ID." do
      joes = Venue.create()
      expect(joes.valid?).to be_falsy
    end
  end

  context "Valid venue" do
    before(:each) do
      @stir_cafe = Venue.create(google_place_id: "ChIJS3rqSBFawokRLT_XRbu-8r8")
    end

    it "has a place ID." do
      expect(@stir_cafe.google_place_id).to be_truthy
    end

    it "has a valid place ID." do
      expect(@stir_cafe.google_place_id.length).to eq(27)
    end
  end
end
