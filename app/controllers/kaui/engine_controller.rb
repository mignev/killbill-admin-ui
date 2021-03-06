class Kaui::EngineController < ApplicationController

  include Kaui::EngineControllerUtil

  before_filter :authenticate_user!, :check_for_redirect_to_tenant_screen

  layout :get_layout

  # Common options for the Kill Bill client
  def options_for_klient(options = {})
    user_tenant_options = Kaui.current_tenant_user_options(current_user, session)
    user_tenant_options.merge(options)
    user_tenant_options
  end

  # Used for auditing purposes
  def current_user
    super
  end


  def current_ability
    # Redefined here to namespace Ability in the correct module
    @current_ability ||= Kaui::Ability.new(current_user)
  end

  def check_for_redirect_to_tenant_screen
    if !Kaui.is_user_assigned_valid_tenant?(current_user, session)
      flash[:error] = "No tenants configured for users AND KillBillClient.api_key, KillBillClient.api_secret have not been set"
      session[:kb_tenant_id] = nil
      redirect_to Kaui.tenant_home_path.call and return
    end
  end


  private

  def current_tenant_user
    user = current_user
    kb_tenant_id = session[:kb_tenant_id]
    user_tenant = Kaui::Tenant.find_by_kb_tenant_id(kb_tenant_id) if kb_tenant_id
    result = {
        :username => user.kb_username,
        :password => user.password,
        :session_id => user.kb_session_id,
    }
    if user_tenant
      result[:api_key] = user_tenant.api_key
      result[:api_secret] = user_tenant.api_secret
    end
    result
  end

end
