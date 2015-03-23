module ApplicationHelper

  def error_messages
    response = ""
    unless flash[:errors].nil?
      flash[:errors].each do |error|
        response += "<p>#{error}</p>\n"
      end
    end
    return "<pre>#{response}</pre>".html_safe
  end

end
