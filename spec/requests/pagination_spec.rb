require 'rails_helper'
RSpec.describe "products/index", type: :view do
  before(:each) do
    # Create a list of 31 products with FactoryGirl
    assign(:newspapers, create_list(:newspaper, 31))
  end

  it "renders a list of products" do
    allow(view).to receive_messages(:will_paginate => nil)
    render
  end
end