require 'csv'

class Api::MessagePresenter
  delegate :content, :format, :id, to: :message

  def initialize(message)
    @message = message
  end

  def as_json(*)
    {
      id: id,
      content: content
    }
  end

  def to_xml(*)
    as_json.to_xml
  end

  def to_csv
    json = as_json
    CSV.generate do |csv|
      csv << json.keys
      csv << json.values
    end
  end

  def empty?
    @message.nil?
  end

  private

  def message
    @message
  end
end
