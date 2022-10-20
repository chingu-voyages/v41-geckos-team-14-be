class TodoItem < ApplicationRecord
  def time
    attributes['time']&.strftime('%H:%M')
  end
end
