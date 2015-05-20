require_relative '../phase6/controller_base'

module Phase7
  class ControllerBase < Phase6::ControllerBase
    def flash
      @flash ||= Flash.new(@req)
    end

  end


end
