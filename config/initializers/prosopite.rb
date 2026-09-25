Rails.application.configure do
  unless Rails.env.production?
    Prosopite.rails_logger = true
    Prosopite.raise = false
  end
end
