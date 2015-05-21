require_relative '../phase7/controller_base'

module Phase8
  class ControllerBase < Phase7::ControllerBase

    #must take in literal url path
    def link_to(name, link)
      "<a href=\"#{link}>\"#{name}</a>".htmlsafe
    end
    #must take in literal url path
    def button_to(name, link, method = "post")
      html_string = "<form method=\"#{method}\" action = \"#{link}\" >"
      html_string += "<input value=\"#{name}\" type=\"submit\"></form>"
      html_string.htmlsafe
    end

  end

end
