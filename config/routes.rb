Rails.application.routes.draw do
  namespace :api do
    resources :tags, only: [:create]
    delete 'tags/:entity_type/:entity_id', to: 'tags#destroy', constraints: { entity_type: Regexp.new([:product, :article].join("|")) }
    get 'tags/:entity_type/:entity_id', to: 'tags#show', constraints: { entity_type: Regexp.new([:product, :article].join("|")) }
 
    resources :stats, only: [:index]
    get 'stats/tags/:tag_id', to: 'stats#show'
  end
end
