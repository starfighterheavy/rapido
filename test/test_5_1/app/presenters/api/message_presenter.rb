class Api::MessagePresenter
  delegate :content, :id, to: :message

  def initialize(message)
    @message = message
  end

  def as_json(*)
    {
      id: id,
      content: content
    }
  end

  private

    def message
      @message
    end
end
