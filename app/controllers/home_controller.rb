class HomeController < ApplicationController
  
  around_filter :shopify_session, :except => 'welcome'
  
  def welcome
    current_host = "#{request.host}#{':' + request.port.to_s if request.port != 80}"
    @callback_url = "http://#{current_host}/login"
  end

  def hiren

  end

  def index
    # get 10 products
    # @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

    # get latest 5 orders
    # @theme = ShopifyAPI::Theme.all
    # # uri = ('botree.myshopify.com', "/admin/themes/#{@theme.first.id}/assets.json")
    # # params =    {
    # #         "asset" => {
    # #     "key" => "templates\/404.liquid",
    # #     "source_key" => "layout\/theme.liquid"
    # # }
    # # }
    #
    # @temp = ShopifyAPI::Asset.new(key: 'templates/4041.liquid', value: File.read('app/views/home/hiren.html') ,theme_id: 11162117)
    # # puts @temp
    # @temp.save

    # @image = ShopifyAPI::Asset.find(key: 'Assets/slide_1.jpg', :params => {:theme_id => @theme.first.id})
    # asset = ShopifyAPI::Asset.new(:key => 'assets/special_hiren.css', :theme_id => @theme.first.id)
    # puts @image
    # uri.query = URI.encode_www_form(params)
    # res = Net::HTTP.get_response(uri)
    # @response = res.body
    # @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })


    if params[:id]
      shop = ShopifyAPI::Shop.current
      product = ShopifyAPI::Product.find(params[:id])
      status = "#{product.title} now available for $#{product.price_range} at #{shop.name}. http://#{shop.domain}/products/#{product.handle}"
      url = URI.encode("http://twitter.com/home?status=#{status}")
      redirect_to url
    else
      # get 10 products
      @products = ShopifyAPI::Product.find(:all, :params => {:limit => 10})

      # get latest 5 orders
      @orders   = ShopifyAPI::Order.find(:all, :params => {:limit => 5, :order => "created_at DESC" })
    end
  end
  
end