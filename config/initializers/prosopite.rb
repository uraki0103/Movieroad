Rails.application.configure do
  config.after_initialize do
    Prosopite.rails_logger = true
    Prosopite.raise = false
  end
end
