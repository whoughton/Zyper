require "test_helper"

# To be handled correctly this spec must end with "Integration Test"
describe "VideoDisplays Integration Test" do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  test "Can retrieve entry page" do
  	get "/"
  	assert_response :success
  end

  test "Entry page has link to listings" do
  	get "/"
  	assert_select "a.main-link", "View Available Videos"
	end

	test "Listings page has Videos" do
		get "/videos"
		assert_select "ul.video-list li", 16
	end

	test "Can paginate from listings page 1" do
		get "/videos"
		assert_select ".page-bar a", "Next Page ▶︎"
	end

	test "Can return home from listings" do
		get "/videos"
		assert_select ".header h2 a", "Demo"
	end

	test "Can get video detail page" do
		get "/videos/56a7b83069702d2f8315d9b7"
		assert_select ".video-details h3", "Winter Storm Jonas Won't Stop Leslie Jones or SNL"
	end

	test "Subscription video should redirect" do
		get "/videos/56a7b83069702d2f830cd9b7"
		assert_response :redirect

		follow_redirect!
		assert_response :success

		assert_select "p.flash", "A subscription is required to view that video."
	end
end
