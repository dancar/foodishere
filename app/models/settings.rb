class Settings < Settingslogic
  source "#{Rails.root}/config/conf.yml"
  namespace Rails.env
end
