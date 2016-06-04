require 'rails_helper'

RSpec.describe "HomeController", type: :feature do
  describe "user visits homepage" do
    it "displays the welcome message" do
      visit '/'
      expect(page).to have_content("Live long and prosper")
    end
   end
 end
