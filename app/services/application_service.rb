# frozen_string_literal: true

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def strike?
    current_frame.ball_1 == 10
  end

  def spare?
    current_frame.ball_1.to_i < 10 &&
      (current_frame.ball_1.to_i + current_frame.ball_2.to_i) == 10
  end
end
