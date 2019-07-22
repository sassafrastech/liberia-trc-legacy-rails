class MailManager < ActionMailer::Base

  def error_message(exception, trace, session, params, env, user)
    recipients(CONF.webmaster_emails)
    set_from
    subject("TRC Site Error: #{env['REQUEST_URI']}")
    body({
      :exception => exception,
      :trace => trace,
      :session => session,
      :params => params,
      :env => env
    })
  end
  
  def set_from
    from(CONF.system_email)
  end
end