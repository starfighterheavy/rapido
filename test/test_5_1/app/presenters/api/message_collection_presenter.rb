class Api::MessageCollectionPresenter
  def initialize(messages, query)
    @messages = messages
    @query = query
  end

  def as_json(*)
    messages.where('content LIKE ?', "%#{@query}%").map { |m| Api::MessagePresenter.new(m).as_json }
  end

  private

  def messages
    @messages
  end
end
