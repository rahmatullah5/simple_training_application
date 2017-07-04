class SearchController < ApplicationController
  def search
    # if params[:term].nil?
    #   @query = []
    # else
    #   @query = Product.search(params[:term]).result#.result
    #   #@query = @query.result
    #   @q = params[:term]
    # end
    if params[:term].nil?
      @product = []
    else
      @product = Product.search(params[:term] , fields: [:name])
    end
    # products.each do |product|
    #   puts product.name
    # end
  end


end
