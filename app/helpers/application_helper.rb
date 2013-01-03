module ApplicationHelper
  # To access a Devise form from a non-Devise controller for that added devise_mapping method
  # to map the model name
  def devise_mapping
    Devise.mappings[:user]
  end

  # To access a Devise form from a non-Devise controller for that added resource_name method
  # to map the resource type going to used
  def resource_name
    devise_mapping.name
  end

  # To access a Devise form from a non-Devise controller for that added resource_class
  def resource_class
    devise_mapping.to
  end
end
