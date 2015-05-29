Rails.application.routes.draw do
  mount Kaui::Engine => "/", :as => "kaui_engine"
end
