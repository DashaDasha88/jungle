require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do

  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products" do
  
    visit root_path
    
    first('.product').click_link('Add')
  
    expect(page).to have_text 'My Cart (1)'
    save_screenshot

  end

end
