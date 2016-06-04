RSpec.describe "home/index.html.erb", type: :view do
  it "contains a heading" do
    render
    expect(rendered).to have_css("h1", text: "Live long and prosper")
  end
end
