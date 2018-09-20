class Api::MessageCollectionPresenter
  def initialize(messages)
    @messages = messages
  end

  def as_json(*)
    messages.map { |m| Api::MessagePresenter.new(m).as_json }
  end

  private

  def messages
    @messages
  end
end
