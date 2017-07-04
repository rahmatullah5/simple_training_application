class SearchController < ApplicationController
  def search
    # if params[:term].nil?
    #   @query = []
    # else
    #   @query = Product.search(params[:term]).result#.result
    #   #@query = @query.result
    #   @q = params[:term]
    # end
    q = (params[:term].present? && params[:term]) || '*'
    @product = Product.search(q , fields: [:name])

    # products.each do |product|
    #   puts product.name
    # end
  end


end
