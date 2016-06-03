require "rails_helper"

RSpec.describe Member, type: :model do
  context "Invalid member" do
    it "is invalid without a uId." do
      einar = Member.create(name: "Einar")
      expect(einar.valid?).to be_falsy
    end

    it "is invalid without a name." do
      einar = Member.create(uid: 999)
      expect(einar.valid?).to be_falsy
    end
  end

  context "Valid member" do
    before(:each) do
      @einar = Member.create(uid: 999, name: "Einar")
    end

    it "has a uid." do
      expect(@einar.uid).to be_truthy
    end

    it "has a name." do
      expect(@einar.name).to be_truthy
    end
  end
end
