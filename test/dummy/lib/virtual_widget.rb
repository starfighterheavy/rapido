class VirtualWidget
  attr_reader :toolbox, :params

  def initialize(toolbox, params = nil)
    @toolbox = toolbox
    @params = params
  end

  def assign_attributes(params)
    @params = params
  end

  def to_h
    {
      "name": params[:name]
    }
  end

  def save
    return true
  end
end
