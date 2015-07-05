ApiApp::Application.routes.draw do
    namespace :api, defaults: { format: 'json' } do
        namespace :v1 do
            resources :sessions, only: [:create, :destroy]
            resources :users
        end
    end
end
