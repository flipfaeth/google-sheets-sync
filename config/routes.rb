Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :google do
    get "sheets/", controller: "google", action: "get_sheet_data"
  end
end
