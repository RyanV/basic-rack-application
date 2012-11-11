require "rubygems"
require "rack"
require "minitest/autorun"

require File.expand_path("lib/application")

describe Application do
  before do
    @request = Rack::MockRequest.new(Application)
  end

  describe "GET /unknown" do
    it "returns a 404 response for unknown requests" do
      assert_equal 404, @request.get("/unknown").status
    end
  end

  describe "GET /" do
    it "should respond with success" do
      assert_equal 200, @request.get("/").status
    end
  end
end
