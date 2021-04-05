require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    @product = Product.new
    @category = Category.new name: 'Apparel'
  end

  it 'has name' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:name]).to include('can\'t be blank')
  end

  it 'has price' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:price]).to include('can\'t be blank')
  end

  it 'has quantity' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
  end

  it 'has category' do
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:category]).to include('can\'t be blank')
  end
  

end