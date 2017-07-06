class SearchController < ApplicationController
  def search
    @q = (params[:term].present? && params[:term]) || '*'
    @product = Product.search(@q , fields: [name: :word_start])
  end
end
