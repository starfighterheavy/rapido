class EmptyWidget
  def initialize(toolbox)
  end

  def to_h
    {
      "status": 'Well done!'
    }
  end

  def save
    return true
  end
end
