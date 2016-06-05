require 'rails_helper'

RSpec.describe "HomeController", type: :feature do
  describe "user visits homepage" do
    before :each do
      visit '/'
      page.save_and_open_page
    end

    it "has a form to allow users to search by type." do
      expect(page).to have_css('form.form-search-by-type')
    end

    it 'displays the title of a venue.' do
      expect(page).to have_css('.venue-title')
    end

    it 'displays an image for the venue.' do
      expect(page).to have_css('.venue-img')
    end

    it 'displays information for a venue.' do
      expect(page).to have_css('.venue-info')
    end

    it "has a show more button for lazy loading." do
      expect(page).to have_css('button.show-more')
    end

    xit "has a log in using Facebook button." do
    end

   end
 end
