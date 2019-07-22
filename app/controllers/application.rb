# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  before_filter(:no_www)
  before_filter(:default_js)
  before_filter(:breadcrumb)

  unless  ActionController::Base.consider_all_requests_local
    rescue_from Exception, :with => :error_500
    rescue_from ActionController::UnknownAction, ActionController::RoutingError, ActionView::MissingTemplate, ActiveRecord::RecordNotFound, :with => :error_404
  end
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '70f604b0014c3c9ff38d81771f99ec8b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
    def no_www
      redirect_to(request.protocol + $1 + request.request_uri) if request.host.match(/^www\.(.+)/)
    end
    
    def default_js
      @js = []
    end
    
    def breadcrumb
      @path_bits = request.env['PATH_INFO'].split("/").collect{|b| b.blank? ? nil : b}.compact
      set_crumb(@path_bits.collect{|p| p.titleize.gsub("Trc", "TRC").gsub("Usa", "USA").gsub("Us", "US").gsub("Contact US", "Contact Us")})
    end
    
    def set_crumb(bits)
      @crumb = [["Home", "/"]] + bits
    end

    def error_404
      show_error_page(404)
      return
    end

    def error_500(exception)
      notify_error(exception) unless exception.is_a?(ActionController::InvalidAuthenticityToken)
      show_error_page(500)
      return
    end
    
    def show_error_page(code)
      render(:template => "errors/#{code}", :status => code)
      return
    end
    
    def notify_error(exception)
      begin
        MailManager.deliver_error_message(exception, clean_backtrace(exception), session.instance_variable_get("@data"),
          params, request.env, @logged_in)
      rescue
        logger.error($!)
      end
    end
end
