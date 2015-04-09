Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shopify, 
           ShopifyApp.configuration.api_key, 
           ShopifyApp.configuration.secret,

           # Example permission scopes - see http://docs.shopify.com/api/tutorials/oauth for full listing
           :scope => 'read_orders, read_products',

           :setup => lambda {|env| 
                       params = Rack::Utils.parse_query(env['QUERY_STRING'])
                       site_url = "https://#{params['shop']}"
                       env['omniauth.strategy'].options[:client_options][:site] = site_url
                     }
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :shopify, 'dd5001b1ad736777d67e702d00338e20', 'ed892fe29b687959d10afcb739366128'
# end