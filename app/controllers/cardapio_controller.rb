class CardapioController < ApplicationController
  def index
    @categories = Product.distinct.pluck(:category)
    @products = Product.all
  end
end
