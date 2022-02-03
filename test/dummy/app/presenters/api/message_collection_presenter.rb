class Api::MessageCollectionPresenter
  def initialize(messages, query)
    @messages = messages
    @query = query
  end

  def as_json(*)
    messages.where('content LIKE ?', "%#{@query}%").map { |m| Api::MessagePresenter.new(m).as_json }
  end

  def to_csv
    json = as_json
    CSV.generate do |csv|
      csv << json[0].keys
      json.each do |row|
        csv << row.values
      end
    end
  end

  private

  def messages
    @messages
  end
end
