RSpec.describe "home/index.html.erb", type: :view do
  it "contains a heading" do
    render
    expect(rendered).to have_css("h2.heading", text: "Is It Open?")
  end
end
