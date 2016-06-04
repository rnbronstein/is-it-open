require 'rails_helper'

RSpec.describe "HomeController", type: :feature do
  describe "user visits homepage" do
    before :each do
      visit '/'
      page.save_and_open_page
    end

    it "displays the welcome message" do
      expect(page).to have_content("Live long and prosper")
    end

    xit "has three bootstrap column divs." do
    end

    xit "has a show more button for lazy loading." do
    end

    xit "has a log in using Facebook button." do
    end

    xit "has a background appended to the body tag." do
    end
   end
 end
